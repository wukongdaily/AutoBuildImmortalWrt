#!/bin/bash
source shell/custom-packages.sh
echo "第三方软件包: $CUSTOM_PACKAGES"

# 从 workflow 传入的 PROFILE
echo "Building for profile: $PROFILE"
echo "Include Docker: $INCLUDE_DOCKER"
echo "Building for ROOTFS_PARTSIZE: $ROOTSIZE"

if [ -z "$CUSTOM_PACKAGES" ]; then
  echo "⚪️ 未选择任何第三方软件包"
else
  # 下载 run 文件仓库
  echo "🔄 正在同步第三方软件仓库..."
  git clone --depth=1 https://github.com/wukongdaily/store.git /tmp/store-run-repo

  # 拷贝 run/arm64 下所有 run 文件和 ipk 文件到 extra-packages 目录
  mkdir -p /home/build/immortalwrt/extra-packages
  cp -r /tmp/store-run-repo/run/arm64/* /home/build/immortalwrt/extra-packages/ 2>/dev/null || true

  echo "✅ Run files copied to extra-packages:"
  ls -lh /home/build/immortalwrt/extra-packages/*.run 2>/dev/null || echo "No .run files found"

  # 解压并拷贝 ipk 到 packages 目录
  sh shell/prepare-packages.sh
  ls -lah /home/build/immortalwrt/packages/

  # 添加架构优先级信息
  ARCH_CONF="/home/build/immortalwrt/files/etc/opkg/arch.conf"
  if [ -f "$ARCH_CONF" ]; then
    echo "📌 Using custom arch.conf from workflow"
    cp "$ARCH_CONF" repositories.conf
  else
    echo "⚙️ Using default Pi5 arch priorities"
    sed -i '1i\
arch aarch64_generic 10\n\
arch aarch64_cortex-a76 15' repositories.conf
  fi
fi

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting build process..."

# 定义所需安装的包列表
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-go-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"

# 24.10 常用插件
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"

# 合并 imm 仓库以外的第三方插件
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"

# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

# 若构建 openclash 则添加核心文件
if echo "$PACKAGES" | grep -q "luci-app-openclash"; then
    echo "✅ 已选择 luci-app-openclash，添加 clash_meta core"
    mkdir -p files/etc/openclash/core
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # 下载 GeoIP 和 GeoSite
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
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ❌ Error: Build failed!"
    tail -n 100 logs/*.log 2>/dev/null || echo "No build logs found."
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - ✅ Build completed successfully."
