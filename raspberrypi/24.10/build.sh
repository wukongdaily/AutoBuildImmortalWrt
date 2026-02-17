#!/bin/bash
source shell/custom-packages.sh
echo "第三方软件包: $CUSTOM_PACKAGES"
# yml 传入的路由器型号 PROFILE
echo "Building for profile: $PROFILE"
echo "Include Docker: $INCLUDE_DOCKER"
# yml 传入的固件大小 ROOTFS_PARTSIZE
echo "Building for ROOTFS_PARTSIZE: $ROOTSIZE"
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
fi


LUCI_VERSION="${LUCI_VERSION:-24.10.4}"  # workflow 传入的luci版本，默认为24.10.4
# 根据 PROFILE 选择 CPU_ARCH
case "$PROFILE" in
  rpi-3)
    CPU_ARCH="aarch64_cortex-a53"
    ;;
  rpi-4)
    CPU_ARCH="aarch64_cortex-a72"
    ;;
  rpi-5)
    CPU_ARCH="aarch64_cortex-a76"
    ;;
  *)
    CPU_ARCH="aarch64_generic"
    ;;
esac

# 插入架构优先级
sed -i "1i\
arch aarch64_generic 10\n\
arch $CPU_ARCH 15" repositories.conf

# 修改树莓派 repositories.conf 仓库路径，使通用包使用 aarch64_generic，并动态填 LUCI_VERSION
sed -i -E "s|(src/gz immortalwrt_base .*aarch64_cortex-a[0-9]+)/base|src/gz immortalwrt_base https://downloads.immortalwrt.org/releases/$LUCI_VERSION/packages/aarch64_generic/base|" repositories.conf
sed -i -E "s|(src/gz immortalwrt_luci .*aarch64_cortex-a[0-9]+)/luci|src/gz immortalwrt_luci https://downloads.immortalwrt.org/releases/$LUCI_VERSION/packages/aarch64_generic/luci|" repositories.conf
sed -i -E "s|(src/gz immortalwrt_packages .*aarch64_cortex-a[0-9]+)/packages|src/gz immortalwrt_packages https://downloads.immortalwrt.org/releases/$LUCI_VERSION/packages/aarch64_generic/packages|" repositories.conf
sed -i -E "s|(src/gz immortalwrt_routing .*aarch64_cortex-a[0-9]+)/routing|src/gz immortalwrt_routing https://downloads.immortalwrt.org/releases/$LUCI_VERSION/packages/aarch64_generic/routing|" repositories.conf
sed -i -E "s|(src/gz immortalwrt_telephony .*aarch64_cortex-a[0-9]+)/telephony|src/gz immortalwrt_telephony https://downloads.immortalwrt.org/releases/$LUCI_VERSION/packages/aarch64_generic/telephony|" repositories.conf
echo "✅ repositories.conf updated for $PROFILE with generic fallback and LUCI_VERSION=$LUCI_VERSION"
echo "Current repositories.conf content:"
cat repositories.conf
# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting build process..."


# 定义所需安装的包列表
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
# 服务——FileBrowser 用户名admin 密码admin
PACKAGES="$PACKAGES luci-i18n-filebrowser-go-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"

#24.10
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
# ======== shell/custom-packages.sh =======
# 合并imm仓库以外的第三方插件
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"

# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

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

make image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$ROOTSIZE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
