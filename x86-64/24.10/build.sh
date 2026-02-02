#!/bin/bash
set -e

echo "=============================="
echo "  Han 专属 x86-64 构建脚本"
echo "=============================="

PROFILE="generic"
INCLUDE_DOCKER="${INCLUDE_DOCKER:-yes}"

# 整合软件包
EXTRA_PACKAGES=""
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    EXTRA_PACKAGES="$EXTRA_PACKAGES docker dockerd docker-compose luci-app-dockerman"
fi

# 【核心修复】直接在这里强制指定 BOARD 和 SUBTARGET
# 这样即使 .config 没读到，make 也会知道去哪里找内核文件
make image \
    PROFILE="$PROFILE" \
    BOARD="x86" \
    SUBTARGET="64" \
    FILES="/home/build/custom_files/files" \
    PACKAGES="$EXTRA_PACKAGES"

echo "构建完成！"
