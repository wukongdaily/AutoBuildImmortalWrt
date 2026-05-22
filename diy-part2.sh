#!/bin/bash
#
# Copyright (c) 2019-2026 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.200/g' package/base-files/files/bin/config_generate

# 单网口旁路由专用：关闭DHCP服务
sed -i '/dhcp.lan.ignore/d' package/network/services/dnsmasq/files/dhcp.conf
echo "dhcp.lan.ignore=1" >> package/network/services/dnsmasq/files/dhcp.conf

# 单网口旁路由专用：设置默认网关和DNS
sed -i '/network.lan.gateway/d' package/base-files/files/bin/config_generate
sed -i '/network.lan.dns/d' package/base-files/files/bin/config_generate
sed -i '/set network.lan.netmask/a\        set network.lan.gateway='\''192.168.2.1'\''' package/base-files/files/bin/config_generate
sed -i '/set network.lan.gateway/a\        set network.lan.dns='\''223.5.5.5'\''' package/base-files/files/bin/config_generate

# 单网口旁路由专用：防火墙默认接受所有转发
sed -i 's/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config
