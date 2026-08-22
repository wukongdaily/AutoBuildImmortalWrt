#!/bin/bash
source shell/custom-packages.sh
echo "第三方软件包: $CUSTOM_PACKAGES"
echo "Building for profile: $PROFILE"
echo "Include Docker: $INCLUDE_DOCKER"
echo "Building for ROOTFS_PARTSIZE: $ROOTSIZE"

# 25.12 使用 apk，跳过 run 文件处理（store 在 25.12 暂不支持）
# 只保留第三方 ipk 包处理
if [ -n "$CUSTOM_PACKAGES" ]; then
  # 检查是否有 store 包名，有则跳过（25.12 不支持）
  if echo "$CUSTOM_PACKAGES" | grep -q "luci-app-store"; then
    echo "⚠️ 25.12 暂不支持 luci-app-store，已跳过"
  fi
  
  # 如果有其他 run 文件或 ipk，仍然处理
  if ls /home/build/immortalwrt/extra-packages/*.run 2>/dev/null | head -1; then
    echo "🔄 处理第三方包..."
    sh shell/prepare-packages.sh 2>/dev/null || true
  fi
fi

LUCI_VERSION="${LUCI_VERSION:-25.12.0}"
case "$PROFILE" in
  rpi-3) CPU_ARCH="aarch64_cortex-a53" ;;
  rpi-4) CPU_ARCH="aarch64_cortex-a72" ;;
  rpi-5) CPU_ARCH="aarch64_cortex-a76" ;;
  *)     CPU_ARCH="aarch64_generic" ;;
esac

echo "✅ 25.12 使用 apk 包管理器"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting build process..."

PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-go-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"

# 科学上网（25.12 支持 passwall/daed/homeproxy，不支持 nikki）
PACKAGES="$PACKAGES luci-app-passwall luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-daed luci-i18n-daed-zh-cn"

# DDNS-Go
PACKAGES="$PACKAGES luci-i18n-ddns-go-zh-cn ddns-go"

PACKAGES="$PACKAGES $CUSTOM_PACKAGES"

# Docker
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn docker dockerd docker-compose"
    echo "Adding Docker packages"
fi

# OpenClash + mihomo 核心（预装 mihomo 内核+GeoIP）
PACKAGES="$PACKAGES luci-app-openclash"
echo "✅ 添加 luci-app-openclash + mihomo 内核"
mkdir -p files/etc/openclash/core
# 下载 mihomo 内核（OpenClash 官方源）
META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta 2>/dev/null && chmod +x files/etc/openclash/core/clash_meta || echo "⚠️ mihomo 内核下载失败"
# GeoIP/GeoSite
wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat 2>/dev/null
wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat 2>/dev/null

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image..."
echo "Packages: $PACKAGES"
make image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$ROOTSIZE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi
echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
