#!/bin/bash
set -e

echo "=============================="
echo "  Han 专属 x86-64 构建脚本"
echo "=============================="

PROFILE="${PROFILE:-generic}"
INCLUDE_DOCKER="${INCLUDE_DOCKER:-yes}"
ENABLE_PPPOE="${ENABLE_PPPOE:-no}"
PPPOE_ACCOUNT="${PPPOE_ACCOUNT:-}"
PPPOE_PASSWORD="${PPPOE_PASSWORD:-}"

echo "当前构建配置："
echo "  PROFILE        = $PROFILE"
echo "  INCLUDE_DOCKER = $INCLUDE_DOCKER"
echo "  ENABLE_PPPOE   = $ENABLE_PPPOE"
echo ""

# ------------------------------
# 1. 载入 .config
# ------------------------------
if [ ! -f ".config" ]; then
    echo "错误：未找到 .config 文件"
    exit 1
fi

echo "载入 .config..."
cp .config .config.bak

# ------------------------------
# 2. 处理 Docker 可选插件
# ------------------------------
EXTRA_PACKAGES=""

if [ "$INCLUDE_DOCKER" = "yes" ]; then
    echo "启用 Docker 插件"
    EXTRA_PACKAGES="$EXTRA_PACKAGES docker dockerd docker-compose luci-app-dockerman"
else
    echo "不启用 Docker 插件"
fi

# ------------------------------
# 3. 处理 PPPoE（可选）
# ------------------------------
if [ "$ENABLE_PPPOE" = "yes" ]; then
    echo "启用 PPPoE 拨号"
    EXTRA_PACKAGES="$EXTRA_PACKAGES ppp ppp-mod-pppoe"

    mkdir -p files/etc/uci-defaults
    cat > files/etc/uci-defaults/99-pppoe.sh <<EOF
uci set network.wan=interface
uci set network.wan.proto='pppoe'
uci set network.wan.username='$PPPOE_ACCOUNT'
uci set network.wan.password='$PPPOE_PASSWORD'
uci commit network
EOF
else
    echo "不启用 PPPoE"
fi

# ------------------------------
# 4. 开始构建
# ------------------------------
echo "开始构建固件..."

make image PROFILE="$PROFILE" \
    FILES="files" \
    PACKAGES="$EXTRA_PACKAGES"

echo "构建完成！"
echo "固件已生成在 bin/targets/x86/64/"

