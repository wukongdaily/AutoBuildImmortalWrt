#!/bin/bash
set -e

echo "=============================="
echo "  Han 专属 x86-64 构建脚本"
echo "=============================="

# 明确指定 PROFILE，x86-64 的 ImageBuilder 默认是 generic
PROFILE="generic"
INCLUDE_DOCKER="${INCLUDE_DOCKER:-yes}"
ENABLE_PPPOE="${ENABLE_PPPOE:-no}"

# 打印配置方便排错
echo "当前构建配置："
echo "  PROFILE        = $PROFILE"
echo "  INCLUDE_DOCKER = $INCLUDE_DOCKER"

# 确定软件包
# 注意：ImageBuilder 不需要手动 cp .config，
# 我们直接在 make image 命令里通过 PACKAGES 覆盖
EXTRA_PACKAGES=""
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    EXTRA_PACKAGES="$EXTRA_PACKAGES docker dockerd docker-compose luci-app-dockerman"
fi

# 执行构建
# 这里的核心是直接调用 make image
make image PROFILE="$PROFILE" \
    FILES="files" \
    PACKAGES="$EXTRA_PACKAGES"

echo "构建完成！"
