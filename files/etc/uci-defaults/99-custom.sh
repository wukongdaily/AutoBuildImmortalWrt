#!/bin/sh
# 99-custom.sh 就是immortalwrt固件首次启动时运行的脚本 位于固件内的/etc/uci-defaults/99-custom.sh
# Log file for debugging
LOGFILE="/tmp/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >> $LOGFILE
# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
uci set firewall.@zone[1].input='ACCEPT'

# 设置主机名映射，解决安卓原生 TV 无法联网的问题
uci add dhcp domain
uci set "dhcp.@domain[-1].name=time.android.com"
uci set "dhcp.@domain[-1].ip=203.107.6.88"

# 检查配置文件pppoe-settings是否存在 该文件由build.sh动态生成
SETTINGS_FILE="/etc/config/pppoe-settings"
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "PPPoE settings file not found. Skipping." >> $LOGFILE
else
   # 读取pppoe信息($enable_pppoe、$pppoe_account、$pppoe_password)
   . "$SETTINGS_FILE"
fi

# 计算网卡数量
count=0
ifnames=""
for iface in /sys/class/net/*; do
  iface_name=$(basename "$iface")
  # 检查是否为物理网卡（排除回环设备和无线设备）
  if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
    count=$((count + 1))
    ifnames="$ifnames $iface_name"
  fi
done
# 删除多余空格
ifnames=$(echo "$ifnames" | awk '{$1=$1};1')

# 网络设置
if [ "$count" -eq 1 ]; then
   # 单网口设备 类似于NAS模式 动态获取ip模式 具体ip地址取决于上一级路由器给它分配的ip 也方便后续你使用web页面设置旁路由
   # 单网口设备 不支持修改ip 不要在此处修改ip 
   uci set network.lan.proto='dhcp'
elif [ "$count" -gt 1 ]; then
   # 提取第一个接口作为WAN
   wan_ifname=$(echo "$ifnames" | awk '{print $1}')
   # 剩余接口保留给LAN
   lan_ifnames=$(echo "$ifnames" | cut -d ' ' -f2-)
   # 设置WAN接口基础配置
   uci set network.wan=interface
   # 提取第一个接口作为WAN
   uci set network.wan.device="$wan_ifname"
   # WAN接口默认DHCP
   uci set network.wan.proto='dhcp'
   # 设置WAN6绑定网口eth0
   uci set network.wan6=interface
   uci set network.wan6.device="$wan_ifname"
   # 更新LAN接口成员
   # 查找对应设备的section名称
   section=$(uci show network | awk -F '[.=]' '/\.@?device\[\d+\]\.name=.br-lan.$/ {print $2; exit}')
   if [ -z "$section" ]; then
      echo "error：cannot find device 'br-lan'." >> $LOGFILE
   else
      # 删除原来的ports列表
      uci -q delete "network.$section.ports"
      # 添加新的ports列表
      for port in $lan_ifnames; do
         uci add_list "network.$section.ports"="$port"
      done
      echo "ports of device 'br-lan' are update." >> $LOGFILE
   fi
   # LAN口设置静态IP
   uci set network.lan.proto='static'
   # 多网口设备 支持修改为别的ip地址,别的地址应该是网关地址，形如192.168.xx.1 项目说明里都强调过。
   # 大家不能胡乱修改哦 比如有人修改为192.168.100.55 这是错误的理解 这个项目不能提前设置旁路地址
   # 旁路的设置分2类情况,情况一是单网口的设备,默认是DHCP模式，ip应该在上一级路由器里查看。之后进入web页在设置旁路。
   # 情况二旁路由如果是多网口设备，也应当用网关访问网页后，在自行在web网页里设置。总之大家不能直接在代码里修改旁路网关。千万不要徒增bug啦。
   uci set network.lan.ipaddr='192.168.100.1'
   uci set network.lan.netmask='255.255.255.0'
   echo "set 192.168.100.1 at $(date)" >> $LOGFILE
   # 判断是否启用 PPPoE
   echo "print enable_pppoe value=== $enable_pppoe" >> $LOGFILE
   if [ "$enable_pppoe" = "yes" ]; then
      echo "PPPoE is enabled at $(date)" >> $LOGFILE
      # 设置ipv4宽带拨号信息
      uci set network.wan.proto='pppoe'
      uci set network.wan.username=$pppoe_account
      uci set network.wan.password=$pppoe_password
      uci set network.wan.peerdns='1'
      uci set network.wan.auto='1'
      # 设置ipv6 默认不配置协议
      uci set network.wan6.proto='none'
      echo "PPPoE configuration completed successfully." >> $LOGFILE
   else
      echo "PPPoE is not enabled. Skipping configuration." >> $LOGFILE
   fi
fi

# 添加docker zone
uci add firewall zone
uci set firewall.@zone[-1].name='docker'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
uci set firewall.@zone[-1].device='docker0'

# 添加 forwarding docker -> lan
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='docker'
uci set firewall.@forwarding[-1].dest='lan'

# 添加 forwarding docker -> wan
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='docker'
uci set firewall.@forwarding[-1].dest='wan'

# 添加 forwarding lan -> docker
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='docker'

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''
uci commit

# 设置编译作者信息
FILE_PATH="/etc/openwrt_release"
NEW_DESCRIPTION="Compiled by wukongdaily"
sed -i "s/DISTRIB_DESCRIPTION='[^']*'/DISTRIB_DESCRIPTION='$NEW_DESCRIPTION'/" "$FILE_PATH"

exit 0
