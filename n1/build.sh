#!/bin/bash
set -e

# ================================
# 旁路由专用构建脚本（YuHan 定制）
# ================================

source shell/custom-packages.sh
LOGFILE="/tmp/uci-defaults-log.txt"

echo "第三方软件包: $CUSTOM_PACKAGES"
echo "Starting build.sh at $(date)" >> $LOGFILE

echo "Building for profile: $PROFILE"
echo "Building for ROOTFS_PARTSIZE: $ROOTFS_PARTSIZE"
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始构建 arm64 rootfs.tar.gz"

# ================================
# ⭐ 1. 旁路由专用 PACKAGES（极简）
# ================================
PACKAGES=""
PACKAGES="$PACKAGES curl fdisk"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon luci-app-argon-config luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"

# Docker（可选）
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "已选择 Docker"
fi

# ================================
# ⭐ 2. 克隆 run 包仓库
# ================================
echo "🔄 正在同步第三方软件仓库..."
git clone --depth=1 https://github.com/wukongdaily/store.git /tmp/store-run-repo

mkdir -p /home/build/immortalwrt/extra-packages
cp -r /tmp/store-run-repo/run/arm64/* /home/build/immortalwrt/extra-packages/

echo "Run 包已复制："
ls -lh /home/build/immortalwrt/extra-packages/*.run

# ================================
# ⭐ 3. 自动过滤 run 包（旁路由专用）
# ================================
echo "开始过滤 run 包，只保留 Passwall2 / MosDNS / TurboACC / Docker..."

RUN_DIR="/home/build/immortalwrt/extra-packages"
mkdir -p "$RUN_DIR-clean"

for f in "$RUN_DIR"/*.run; do
  case "$f" in
    *passwall2*|*mosdns*|*turboacc*|*docker*)
      echo "保留: $f"
      cp "$f" "$RUN_DIR-clean/"
      ;;
    *)
      echo "删除: $f"
      ;;
  esac
done

rm -rf "$RUN_DIR"
mv "$RUN_DIR-clean" "$RUN_DIR"

echo "run 包过滤完成。"
echo "=============================="

# ================================
# ⭐ 4. 解压 run 包 → 生成 ipk
# ================================
sh shell/prepare-packages.sh
ls -lah /home/build/immortalwrt/packages/

# ================================
# ⭐ 5. 添加架构优先级
# ================================
sed -i '1i\
arch aarch64_generic 10\n\
arch aarch64_cortex-a53 15' repositories.conf

# ================================
# ⭐ 6. 合并自定义插件
# ================================
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"

# ================================
# ⭐ 7. 构建镜像
# ================================
echo "构建镜像，包含以下插件："
echo "$PACKAGES"

make image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$ROOTFS_PARTSIZE

if [ $? -ne 0 ]; then
    echo "❌ 构建失败"
    exit 1
fi

echo "🎉 构建成功 $(date '+%Y-%m-%d %H:%M:%S')"
