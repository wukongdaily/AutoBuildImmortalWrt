#!/bin/bash
# Log file for debugging
source shell/custom-packages.sh
echo "第三方软件包: $CUSTOM_PACKAGES"
LOGFILE="/tmp/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >> $LOGFILE
# yml 传入的路由器型号 PROFILE
echo "Building for profile: $PROFILE"
# yml 传入的固件大小 ROOTFS_PARTSIZE
echo "Building for ROOTFS_PARTSIZE: $ROOTFS_PARTSIZE"

echo "Create pppoe-settings"
mkdir -p  /home/build/immortalwrt/files/etc/config

# 创建pppoe配置文件 yml传入环境变量ENABLE_PPPOE等 写入配置文件 供99-custom.sh读取
cat << EOF > /home/build/immortalwrt/files/etc/config/pppoe-settings
enable_pppoe=${ENABLE_PPPOE}
pppoe_account=${PPPOE_ACCOUNT}
pppoe_password=${PPPOE_PASSWORD}
EOF

echo "cat pppoe-settings"
cat /home/build/immortalwrt/files/etc/config/pppoe-settings

if [ -z "$CUSTOM_PACKAGES" ]; then
  echo "⚪️ 未选择 任何第三方软件包"
else
  # 下载 run 文件仓库
  echo "🔄 正在同步第三方软件仓库 Cloning run file repo..."
  git clone --depth=1 https://github.com/wukongdaily/store.git /tmp/store-run-repo

  # 拷贝 run/arm64 下所有 run 文件和ipk文件 到 extra-packages 目录
  mkdir -p /home/build/immortalwrt/extra-packages
  cp -r /tmp/store-run-repo/run/arm64/* /home/build/immortalwrt/extra-packages/

  echo "✅ Run files copied to extra-packages:"
  ls -lh /home/build/immortalwrt/extra-packages/*.run
  # 解压并拷贝ipk到packages目录
  sh shell/prepare-packages.sh
  ls -lah /home/build/immortalwrt/packages/
  # 添加架构优先级信息
  sed -i '1i\
  arch aarch64_generic 10\n\
  arch aarch64_cortex-a53 15' repositories.conf
fi

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始构建QEMU-arm64固件..."


# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
PACKAGES="$PACKAGES git"
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES wget"
PACKAGES="$PACKAGES luci-app-accesscontrol"
PACKAGES="$PACKAGES luci-app-acl"
PACKAGES="$PACKAGES luci-app-acme"
PACKAGES="$PACKAGES luci-i18n-adblock-zh-cn"
PACKAGES="$PACKAGES luci-app-adbyby-plus"
PACKAGES="$PACKAGES luci-app-adguardhome"
PACKAGES="$PACKAGES luci-app-advanced"
PACKAGES="$PACKAGES luci-app-advancedplus"
PACKAGES="$PACKAGES luci-i18n-advanced-reboot-zh-cn"
PACKAGES="$PACKAGES luci-i18n-openlist-zh-cn"
PACKAGES="$PACKAGES luci-app-apinger"
PACKAGES="$PACKAGES luci-app-appfilter"
PACKAGES="$PACKAGES luci-i18n-aria2-zh-cn"
PACKAGES="$PACKAGES luci-i18n-arpbind-zh-cn"
PACKAGES="$PACKAGES luci-i18n-attendedsysupgrade-zh-cn"
PACKAGES="$PACKAGES luci-i18n-autoreboot-zh-cn"
PACKAGES="$PACKAGES luci-app-bandwidthd"
PACKAGES="$PACKAGES luci-i18n-banip-zh-cn"
PACKAGES="$PACKAGES luci-i18n-bcp38-zh-cn"
PACKAGES="$PACKAGES luci-i18n-cd8021x-zh-cn"
PACKAGES="$PACKAGES luci-app-bypass"
PACKAGES="$PACKAGES luci-app-cifs"
PACKAGES="$PACKAGES luci-i18n-cifs-mount-zh-cn"
PACKAGES="$PACKAGES luci-i18n-clamav-zh-cn"
PACKAGES="$PACKAGES luci-i18n-commands-zh-cn"
PACKAGES="$PACKAGES luci-i18n-cpulimit-zh-cn"
PACKAGES="$PACKAGES luci-i18n-cshark-zh-cn"
PACKAGES="$PACKAGES luci-i18n-dawn-zh-cn"
PACKAGES="$PACKAGES luci-i18n-crowdsec-firewall-bouncer-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ddns-go-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ddns-zh-cn"
PACKAGES="$PACKAGES luci-i18n-docker-zh-cn"
PACKAGES="$PACKAGES luci-i18n-dufs-zh-cn"
PACKAGES="$PACKAGES luci-i18n-dynapoint-zh-cn"
PACKAGES="$PACKAGES luci-app-easymesh"
PACKAGES="$PACKAGES luci-i18n-eqos--zh-cn"
PACKAGES="$PACKAGES luci-app-eqosplus"
PACKAGES="$PACKAGES luci-app-filetransfer"
PACKAGES="$PACKAGES luci-i18n-frpc-zh-cn"
PACKAGES="$PACKAGES luci-i18n-frps-zh-cn"
PACKAGES="$PACKAGES luci-i18n-fwknopd-zh-cn"
PACKAGES="$PACKAGES luci-app-gecoosac"
PACKAGES="$PACKAGES luci-i18n-hd-idle-zh-cn"
PACKAGES="$PACKAGES luci-app-hypermodem"
PACKAGES="$PACKAGES luci-app-ikoolproxy"
PACKAGES="$PACKAGES luci-app-ledtrig-usbport"
PACKAGES="$PACKAGES luci-app-leigod-acc"
PACKAGES="$PACKAGES luci-i18n-lxc-zh-cn"
PACKAGES="$PACKAGES luci-i18n-natmap-zh-cn"
PACKAGES="$PACKAGES luci-app-netspeedtest"
PACKAGES="$PACKAGES luci-i18n-nfs-zh-cn"
PACKAGES="$PACKAGES luci-i18n-nlbwmon-zh-cn"
PACKAGES="$PACKAGES luci-i18n-nut-zh-cn"
PACKAGES="$PACKAGES luci-app-oaf"
PACKAGES="$PACKAGES luci-i18n-oled-zh-cn"
PACKAGES="$PACKAGES luci-app-onliner"
PACKAGES="$PACKAGES luci-app-opkg"
PACKAGES="$PACKAGES luci-app-partexp"
PACKAGES="$PACKAGES luci-app-polipo"
PACKAGES="$PACKAGES luci-app-poweroff"
PACKAGES="$PACKAGES luci-i18n-pppoe-relay-zh-cn"
PACKAGES="$PACKAGES luci-i18n-pppoe-server-zh-cn"
PACKAGES="$PACKAGES luci-app-pushbot"
PACKAGES="$PACKAGES luci-i18n-ramfreei18n"
PACKAGES="$PACKAGES luci-app-serverchan"
PACKAGES="$PACKAGES luci-i18n-smartdns-zh-cn"
PACKAGES="$PACKAGES luci-i18n-splash-zh-cn"
PACKAGES="$PACKAGES luci-i18n-sshtunnel-zh-cn"
PACKAGES="$PACKAGES luci-app-store"
PACKAGES="$PACKAGES luci-app-syncdia"
PACKAGES="$PACKAGES luci-app-timecontrol"
PACKAGES="$PACKAGES luci-i18n-timewol-zh-cn"
PACKAGES="$PACKAGES luca-i18n-upnp-zh-cn"
PACKAGES="$PACKAGES luci-app-usbmodem"
PACKAGES="$PACKAGES luci-app-usb-printer"
PACKAGES="$PACKAGES luci-app-usteer"
PACKAGES="$PACKAGES luci-app-uugamebooster"
PACKAGES="$PACKAGES luci-app-webadmin"
PACKAGES="$PACKAGES luci-app-webrestriction"
PACKAGES="$PACKAGES luci-app-weburl"
PACKAGES="$PACKAGES luci-i18n-wechatpush-zh-cn"
PACKAGES="$PACKAGES luci-i18n-wifischedule-zh-cn"
PACKAGES="$PACKAGES luci-i18n-wol-zh-cn"
PACKAGES="$PACKAGES luci-app-wrtbwmon"
PACKAGES="$PACKAGES ipv6helper"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
# 服务——FileBrowser 用户名admin 密码admin
PACKAGES="$PACKAGES luci-i18n-filebrowser-go-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
PACKAGES="$PACKAGES openssh-server"
PACKAGES="$PACKAGES openssh-client"
PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"
# 文件管理器
PACKAGES="$PACKAGES luci-i18n-filemanager-zh-cn"
# 静态文件服务器dufs(推荐)
PACKAGES="$PACKAGES luci-i18n-dufs-zh-cn"
# ======== shell/custom-packages.sh =======
# 合并imm仓库以外的第三方插件
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"

# 若构建openclash 则添加内核
if echo "$PACKAGES" | grep -q "luci-app-openclash"; then
    echo "✅ 已选择 luci-app-openclash，添加 openclash core"
    mkdir -p files/etc/openclash/core
    # Download clash_meta
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # Download GeoIP and GeoSite
    wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat
    wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat
else
    echo "⚪️ 未选择 luci-app-openclash"
fi


# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$ROOTFS_PARTSIZE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
