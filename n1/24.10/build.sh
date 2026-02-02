#!/bin/bash
set -e

echo "=============================="
echo "  Han 专属 N1 构建脚本"
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

# 载入 .config
cp .config .config.bak

EXTRA_PACKAGES=""

if [ "$INCLUDE_DOCKER" = "yes" ]; then
    EXTRA_PACKAGES="$EXTRA_PACKAGES docker dockerd docker-compose luci-app-dockerman"
fi

if [ "$ENABLE_PPPOE" = "yes" ]; then
    EXTRA_PACKAGES="$EXTRA_PACKAGES ppp ppp-mod-pppoe"

    mkdir -p files/etc/uci-defaults
    cat > files/etc/uci-defaults/99-pppoe.sh <<EOF
uci set network.wan=interface
uci set network.wan.proto='pppoe'
uci set network.wan.username='$PPPOE_ACCOUNT'
uci set network.wan.password='$PPPOE_PASSWORD'
uci commit network
EOF
fi

make image PROFILE="$PROFILE" \
    FILES="files" \
    PACKAGES="$EXTRA_PACKAGES"

echo "构建完成！"
