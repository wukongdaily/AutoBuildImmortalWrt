#!/bin/bash

echo "编译固件大小为: $PROFILE MB"

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始编译..."



# 定义所需安装的包列表
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-opkg-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-app-autoreboot"
PACKAGES="$PACKAGES luci-app-vlmcsd"
PACKAGES="$PACKAGES luci-app-wol"
PACKAGES="$PACKAGES luci-app-syncdial"
PACKAGES="$PACKAGES luci-app-turboacc"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES openssh-sftp-server"
PACKAGES="$PACKAGES luci-i18n-zerotier-zh-cn"
PACKAGES="$PACKAGES luci-app-pgyvpn"
PACKAGES="$PACKAGES luci-app-ntpc"

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$PROFILE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
