#!/bin/bash
# Packages selected from the live ESXi ImmortalWrt router at 192.168.10.99.
# Keep secrets and node subscriptions out of the firmware image.

# Core router tools currently used on the live router.
CUSTOM_PACKAGES="$CUSTOM_PACKAGES curl"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES block-mount fdisk sfdisk partx-utils"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES f2fs-tools f2fsck kmod-fs-f2fs"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES dnsmasq-full"

# LuCI applications currently present.
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-argon-config luci-i18n-argon-config-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-attendedsysupgrade luci-i18n-attendedsysupgrade-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddns-go luci-i18n-ddns-go-zh-cn ddns-go"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-firewall luci-i18n-firewall-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-package-manager luci-i18n-package-manager-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-vlmcsd luci-i18n-vlmcsd-zh-cn vlmcsd"

# WireGuard as used by the live router. Private keys are injected after flashing.
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-proto-wireguard wireguard-tools kmod-wireguard"

# PassWall stack from the live router.
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-passwall luci-i18n-passwall-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES xray-core sing-box hysteria chinadns-ng haproxy geoview"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES ipt2socks dns2socks microsocks"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES kmod-nft-socket kmod-nft-tproxy kmod-tun"
