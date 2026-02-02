#!/bin/bash
set -e

echo "=============================="
echo "  Han 专属 x86-64 构建脚本"
echo "=============================="

# 1. 修正 PROFILE 指向。对于 x86-64，Image Builder 默认通常是 generic
PROFILE="generic" 
INCLUDE_DOCKER="${INCLUDE_DOCKER:-yes}"
ENABLE_PPPOE="${ENABLE_PPPOE:-no}"

# --- 核心修复开始 ---
# 2. 这里的路径必须指向你上一级的 imm.config
# 因为 Docker 运行脚本时，当前目录是 x86-64/24.10/
if [ -f "../imm.config" ]; then
    echo "检测到配置文件: ../imm.config，正在注入..."
    cp ../imm.config .config
else
    echo "错误: 找不到配置文件 ../imm.config，请检查路径！"
    exit 1
fi
# --- 核心修复结束 ---

echo "当前构建配置："
echo "  PROFILE        = $PROFILE"
echo "  INCLUDE_DOCKER = $INCLUDE_DOCKER"
echo ""

# 定义额外包
EXTRA_PACKAGES=""
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    EXTRA_PACKAGES="$EXTRA_PACKAGES docker dockerd docker-compose luci-app-dockerman"
fi

# 执行构建
# 注意：Image Builder 的命令是 make image，PACKAGES 参数会叠加在 .config 之上
make image PROFILE="$PROFILE" \
    FILES="files" \
    PACKAGES="$EXTRA_PACKAGES"

echo "构建完成！"
