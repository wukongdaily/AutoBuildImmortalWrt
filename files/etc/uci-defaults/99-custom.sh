#!/bin/sh
# 99-custom.sh —— ImmortalWrt 固件首次启动脚本(固件内路径 /etc/uci-defaults/99-custom.sh)
# 特性:首次启动执行一次,执行完自动删除,所有改动通过 uci 落盘到 /etc/config/
#
# ============ 本版相对原版(wukongdaily)的改动 ============
# 1. 多网口:前两个物理口做双 WAN(WAN 主 + WAN2 备),其余网口进 br-lan
# 2. 默认管理地址改为 192.168.8.1(仍可用 /etc/config/custom_router_ip.txt 覆盖)
# 3. 品牌信息改为 "Packaged by kevis"
# 4. 双 WAN 用 metric 区分默认路由(主 10 / 备 20),避免两条默认路由互相打架
# 5. 修复隐患:
#    a) br-lan 定位正则在 BusyBox awk 下失效(\d 不支持)→ 改用 grep+cut 精确定位
#    b) ttyd / dropbear 未判空,没装就 uci delete 会报错 → 加存在性判断
#    c) nginx 可能被多个插件重复写入 80 端口监听导致启动失败 → 加前置清理
#    d) docker 防火墙段混用 cat 追加文本且不 commit → 全部改为 uci 标准写法
#    e) 防火墙 zone 用写死索引 @zone[1] → 改为按 name 动态查找,避免索引漂移
# =========================================================

LOGFILE="/etc/config/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >>$LOGFILE

# ---------- 工具:按 name 查找防火墙 zone 的索引(匿名 section 不能用名字直接访问) ----------
find_zone_idx() {
    for i in $(uci show firewall 2>/dev/null | grep -E "firewall\.@zone\[[0-9]+\]=zone" | cut -d[ -f2 | cut -d] -f1); do
        if [ "$(uci -q get "firewall.@zone[$i].name")" = "$1" ]; then
            echo "$i"
            return 0
        fi
    done
    echo ""
}

# 1. 默认放行 WAN 入站,方便单网口虚拟机首次就能访问 WebUI
#    刷机调好之后,建议在 网络→防火墙→WAN→入站数据 改回"拒绝"
wan_zone_idx=$(find_zone_idx wan)
[ -z "$wan_zone_idx" ] && wan_zone_idx=1
uci set "firewall.@zone[$wan_zone_idx].input"='ACCEPT'
echo "WAN firewall zone index: $wan_zone_idx" >>$LOGFILE

# 2. 主机名映射,解决安卓原生 TV 无法联网(时间校验)的问题
uci -q add dhcp domain
uci set "dhcp.@domain[-1].name=time.android.com"
uci set "dhcp.@domain[-1].ip=203.107.6.88"

# 3. PPPoE 配置(文件由 build.sh 动态生成)
SETTINGS_FILE="/etc/config/pppoe-settings"
enable_pppoe=""
pppoe_account=""
pppoe_password=""
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "PPPoE settings file not found. Skipping." >>$LOGFILE
else
    . "$SETTINGS_FILE"
fi

# 4. 探测所有物理网口
ifnames=""
for iface in /sys/class/net/*; do
    iface_name=$(basename "$iface")
    if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
        ifnames="$ifnames $iface_name"
    fi
done
ifnames=$(echo "$ifnames" | awk '{$1=$1};1')
count=$(echo "$ifnames" | wc -w)
echo "Detected physical interfaces: $ifnames" >>$LOGFILE
echo "Interface count: $count" >>$LOGFILE

# 5. 个别开发板网口顺序特殊,把指定的口排到最前面
board_name=$(cat /tmp/sysinfo/board_name 2>/dev/null || echo "unknown")
echo "Board detected: $board_name" >>$LOGFILE
case "$board_name" in
    "radxa,e20c"|"friendlyarm,nanopi-r5c")
        ordered=""
        for preferred in eth1 eth0; do
            for i in $ifnames; do
                [ "$i" = "$preferred" ] && ordered="$ordered $i"
            done
        done
        # 其余没排到的口追加到后面
        for i in $ifnames; do
            case " $ordered " in
                *" $i "*) ;;
                *) ordered="$ordered $i" ;;
            esac
        done
        ifnames=$(echo "$ordered" | awk '{$1=$1};1')
        echo "Using $board_name mapping, reordered: $ifnames" >>$LOGFILE
        ;;
esac

# 6. 按网口数量划分 WAN / LAN
wan1_ifname=""
wan2_ifname=""
lan_ifnames=""
if [ "$count" -eq 1 ]; then
    echo "Single port device, LAN runs in DHCP mode." >>$LOGFILE
elif [ "$count" -eq 2 ]; then
    # 只有两个口:第一个做 WAN,第二个留给 LAN,否则没有口能连管理后台
    wan1_ifname=$(echo "$ifnames" | awk '{print $1}')
    lan_ifnames=$(echo "$ifnames" | awk '{print $2}')
    echo "Only 2 ports: WAN=$wan1_ifname LAN=$lan_ifnames (WAN2 disabled)" >>$LOGFILE
else
    # 前两个口做双 WAN,其余全部进 br-lan
    wan1_ifname=$(echo "$ifnames" | awk '{print $1}')
    wan2_ifname=$(echo "$ifnames" | awk '{print $2}')
    lan_ifnames=$(echo "$ifnames" | cut -d ' ' -f3-)
    echo "Dual WAN: WAN1=$wan1_ifname WAN2=$wan2_ifname LAN=$lan_ifnames" >>$LOGFILE
fi

# 7. 配置网络
if [ "$count" -eq 1 ]; then
    # ---------- 单网口:DHCP 模式,插上就能上网并访问后台 ----------
    uci set network.lan.proto='dhcp'
    uci -q delete network.lan.ipaddr
    uci -q delete network.lan.netmask
    uci -q delete network.lan.gateway
    uci -q delete network.lan.dns
    uci commit network

elif [ "$count" -ge 2 ]; then
    # ---------- WAN1(主链路) ----------
    uci set network.wan=interface
    uci set network.wan.device="$wan1_ifname"
    uci set network.wan.proto='dhcp'
    uci set network.wan.metric='10'      # 跃点小,默认路由优先走它
    uci set network.wan.peerdns='1'
    uci set network.wan.auto='1'

    uci set network.wan6=interface
    uci set network.wan6.device="$wan1_ifname"
    uci set network.wan6.proto='dhcpv6'
    uci set network.wan6.auto='1'

    # ---------- WAN2(备用链路) ----------
    # 开关:固件内放 /etc/config/custom_wan2.txt,内容为 no/off/0 时关闭 WAN2(该口回归 LAN)
    wan2_enable="yes"
    WAN2_FILE="/etc/config/custom_wan2.txt"
    if [ -f "$WAN2_FILE" ]; then
        wan2_flag=$(cat "$WAN2_FILE" | tr -d ' \t\r\n' | tr 'A-Z' 'a-z')
        case "$wan2_flag" in
            no|off|0|false|disable|disabled) wan2_enable="no" ;;
        esac
    fi
    if [ "$wan2_enable" = "no" ]; then
        echo "WAN2 disabled by custom_wan2.txt, $wan2_ifname falls back to LAN." >>$LOGFILE
        lan_ifnames="$wan2_ifname $lan_ifnames"
        wan2_ifname=""
    fi

    if [ -n "$wan2_ifname" ]; then
        uci set network.wan2=interface
        uci set network.wan2.device="$wan2_ifname"
        uci set network.wan2.proto='dhcp'
        uci set network.wan2.metric='20'  # 跃点大,主链路断了才接管
        uci set network.wan2.peerdns='0'  # DNS 统一由 WAN1 下发,避免两边 DNS 打架
        uci set network.wan2.auto='1'

        uci set network.wan26=interface
        uci set network.wan26.device="$wan2_ifname"
        uci set network.wan26.proto='dhcpv6'
        uci set network.wan26.auto='1'
    fi

    # ---------- br-lan:装载其余网口 ----------
    section=$(uci show network 2>/dev/null | grep -E "\.name='br-lan'$" | head -1 | cut -d. -f2)
    if [ -z "$section" ]; then
        echo "error: cannot find device 'br-lan'." >>$LOGFILE
    else
        uci -q delete "network.$section.ports"
        for port in $lan_ifnames; do
            uci add_list "network.$section.ports"="$port"
        done
        echo "Updated br-lan($section) ports: $lan_ifnames" >>$LOGFILE
    fi

    # ---------- LAN 静态地址 ----------
    uci set network.lan.proto='static'
    uci set network.lan.netmask='255.255.255.0'
    # 支持 GitHub Action UI 自定义后台地址;没填则默认 192.168.8.1
    IP_VALUE_FILE="/etc/config/custom_router_ip.txt"
    if [ -f "$IP_VALUE_FILE" ] && [ -n "$(cat "$IP_VALUE_FILE" | tr -d ' \t\r\n')" ]; then
        CUSTOM_IP=$(cat "$IP_VALUE_FILE" | tr -d ' \t\r\n')
        uci set network.lan.ipaddr="$CUSTOM_IP"
        echo "custom router ip is $CUSTOM_IP" >>$LOGFILE
    else
        uci set network.lan.ipaddr='192.168.8.1'
        echo "default router ip is 192.168.8.1" >>$LOGFILE
    fi

    # ---------- PPPoE:拨号走 WAN1 主口,WAN2 保持 DHCP 作备用 ----------
    echo "enable_pppoe value: $enable_pppoe" >>$LOGFILE
    if [ "$enable_pppoe" = "yes" ]; then
        echo "PPPoE enabled, configuring on WAN1..." >>$LOGFILE
        uci set network.wan.proto='pppoe'
        uci set network.wan.username="$pppoe_account"
        uci set network.wan.password="$pppoe_password"
        uci set network.wan.peerdns='1'
        uci set network.wan.auto='1'
        uci set network.wan6.proto='none'
        echo "PPPoE config done." >>$LOGFILE
    else
        echo "PPPoE not enabled." >>$LOGFILE
    fi

    # ---------- 关键:WAN2 必须挂进 wan 防火墙 zone,否则没有 NAT 上不了网 ----------
    uci -q delete "firewall.@zone[$wan_zone_idx].network"
    uci add_list "firewall.@zone[$wan_zone_idx].network"='wan'
    uci add_list "firewall.@zone[$wan_zone_idx].network"='wan6'
    if [ -n "$wan2_ifname" ]; then
        uci add_list "firewall.@zone[$wan_zone_idx].network"='wan2'
        uci add_list "firewall.@zone[$wan_zone_idx].network"='wan26'
    fi
    uci commit firewall
    uci commit network
fi

# 8. 放开网页终端 / SSH 的监听网卡(全部网口可连)
if uci -q show ttyd.@ttyd[0] >/dev/null 2>&1; then
    uci -q delete ttyd.@ttyd[0].interface
    uci commit ttyd
fi
if uci -q show dropbear.@dropbear[0] >/dev/null 2>&1; then
    uci set dropbear.@dropbear[0].Interface=''
    uci commit dropbear
fi

# 9. 品牌信息
FILE_PATH="/etc/openwrt_release"
NEW_DESCRIPTION="Packaged by kevis"
if [ -f "$FILE_PATH" ]; then
    sed -i "s/DISTRIB_DESCRIPTION='[^']*'/DISTRIB_DESCRIPTION='$NEW_DESCRIPTION'/" "$FILE_PATH"
else
    echo "DISTRIB_DESCRIPTION='$NEW_DESCRIPTION'" >>"$FILE_PATH"
fi

# 10. luci-app-advancedplus(进阶设置)已安装时,去掉 zsh 调用
#     防止命令行刷 /usr/bin/zsh: not found
if [ -f /usr/lib/lua/luci/controller/advancedplus.lua ]; then
    sed -i '/\/usr\/bin\/zsh/d' /etc/profile
    sed -i '/\/bin\/zsh/d' /etc/init.d/advancedplus
    sed -i '/\/usr\/bin\/zsh/d' /etc/init.d/advancedplus
    echo "fix ttyd show msg: /usr/bin/zsh: not found" >>$LOGFILE
fi

# 11. quickfile 文件管理器:修好 nginx 配置
#     注意:quickfile 与 luci-app-run 的 nginx 配置冲突,这里以 quickfile 为准
if [ -f /usr/bin/quickfile ] && command -v nginx >/dev/null 2>&1; then
    if [ -f /usr/lib/lua/luci/controller/run.lua ] || [ -d /www/luci-static/resources/view/run ]; then
        echo "warn: luci-app-run detected, nginx 80 port taken over by quickfile." >>$LOGFILE
    fi

    uci set nginx.global.uci_enable='true'

    # 先清理:已存在的 _lan / _redirect2ssl
    uci -q delete nginx._lan
    uci -q delete nginx._redirect2ssl
    # 再兜底:任何占用 "80 default_server" 的 server 段一律清掉,防止 nginx 启动失败
    for idx in $(uci show nginx 2>/dev/null | grep -E "nginx\.@server\[[0-9]+\]=server" | cut -d[ -f2 | cut -d] -f1 | sort -rn); do
        listens=$(uci -q get "nginx.@server[$idx].listen")
        case "$listens" in
            *"80 default_server"*)
                echo "removing duplicated nginx server @server[$idx]" >>$LOGFILE
                uci -q delete "nginx.@server[$idx]"
                ;;
        esac
    done

    uci add nginx server >/dev/null
    uci rename nginx.@server[-1]='_lan'
    uci set nginx._lan.server_name='_lan'
    uci add_list nginx._lan.listen='80 default_server'
    uci add_list nginx._lan.listen='[::]:80 default_server'
    uci add_list nginx._lan.include='conf.d/*.locations'
    uci set nginx._lan.access_log='off; # logd openwrt'

    uci commit nginx
    echo "fix quickfile nginx config" >>$LOGFILE
fi

# 12. dockerd 存在则配置防火墙(扩大子网到 172.16.0.0/12,容器端口顺畅通行)
if command -v dockerd >/dev/null 2>&1; then
    echo "检测到 Docker,正在配置防火墙规则..." >>$LOGFILE

    # 删除旧的 docker zone
    uci -q delete firewall.docker
    # 倒序删除所有指向 docker 的 forwarding(倒序删除才不会索引错位)
    for idx in $(uci show firewall 2>/dev/null | grep -E "firewall\.@forwarding\[[0-9]+\]=forwarding" | cut -d[ -f2 | cut -d] -f1 | sort -rn); do
        src=$(uci -q get "firewall.@forwarding[$idx].src")
        dest=$(uci -q get "firewall.@forwarding[$idx].dest")
        if [ "$src" = "docker" ] || [ "$dest" = "docker" ]; then
            echo "Deleting forwarding @forwarding[$idx]" >>$LOGFILE
            uci -q delete "firewall.@forwarding[$idx]"
        fi
    done
    uci commit firewall

    # 用 uci 标准写法重建(原版用 cat 追加文本且不 commit,容易留坑)
    uci set firewall.docker=zone
    uci set firewall.docker.name='docker'
    uci set firewall.docker.input='ACCEPT'
    uci set firewall.docker.output='ACCEPT'
    uci set firewall.docker.forward='ACCEPT'
    uci add_list firewall.docker.subnet='172.16.0.0/12'

    add_fwd() {
        s=$(uci add firewall forwarding)
        uci set "$s.src"="$1"
        uci set "$s.dest"="$2"
    }
    add_fwd docker lan
    add_fwd docker wan
    add_fwd lan docker

    uci commit firewall
    echo "Docker firewall rules applied." >>$LOGFILE
else
    echo "未检测到 Docker,跳过防火墙配置。" >>$LOGFILE
fi

# 兜底提交所有未提交的改动
uci commit

echo "Finished 99-custom.sh at $(date)" >>$LOGFILE
exit 0
