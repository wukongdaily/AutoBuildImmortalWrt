#!/bin/bash
# Log file for debugging
LOGFILE="/tmp/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >> $LOGFILE
echo "编译固件大小为: $PROFILE MB"
echo "Include Docker: $INCLUDE_DOCKER"

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
# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始编译..."



# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-zh-cn"
ACKAGES="$PACKAGES luci-i18n-argon-config"
PACKAGES="$PACKAGES luci-i18n-opkg-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ddns-zh-cn"
PACKAGES="$PACKAGES luci-i18n-smartdns-zh-cn"
PACKAGES="$PACKAGES luci-i18n-upnp-zh-cn"
PACKAGES="$PACKAGES luci-i18n-airplay2-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-zh-cn"
PACKAGES="$PACKAGES luci-app-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-usb-printer-zh-cn"
PACKAGES="$PACKAGES luci-i18n-aria2-zh-cn"
PACKAGES="$PACKAGES luci-i18n-wechatpush-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ddns-zh-cn"
PACKAGES="$PACKAGES luci-theme-openwrt-2020"
PACKAGES="$PACKAGES luci-i18n-alist-zh-cn"
PACKAGES="$PACKAGES luci-i18n-arpbind-zh-cn"
PACKAGES="$PACKAGES luci-i18n-attendedsysupgrade-zh-cn"
PACKAGES="$PACKAGES luci-app-unblockneteasemusic"
PACKAGES="$PACKAGES luci-i18n-wechatpush-zh-cn"
PACKAGES="$PACKAGES luci-i18n-vnstat2-zh-cn"
PACKAGES="$PACKAGES luci-app-syncdial"
PACKAGES="$PACKAGES luci-i18n-oled-zh-cn"
PACKAGES="$PACKAGES luci-i18n-speederv2-zh-cn"
PACKAGES="$PACKAGES luci-i18n-clamav-zh-cn"
PACKAGES="$PACKAGES luci-i18n-gost-zh-cn"
PACKAGES="$PACKAGES luci-i18n-mjpg-streamer-zh-cn"
PACKAGES="$PACKAGES luci-i18n-p910nd-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
# 增加几个必备组件 方便用户安装iStore
PACKAGES="$PACKAGES fdisk"
PACKAGES="$PACKAGES script-utils"
PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"

# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$PROFILE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
