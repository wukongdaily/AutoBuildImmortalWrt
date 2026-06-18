#!/bin/sh
# First-boot profile for the live ESXi ImmortalWrt router.
# Source machine: 192.168.10.99, ImmortalWrt 24.10.4 x86/64.

LOGFILE="/etc/config/uci-defaults-log.txt"
echo "Starting router profile at $(date)" >> "$LOGFILE"

# Network layout from the live router:
#   LAN bridge: eth0 eth2
#   WAN: eth1 DHCP
#   LAN IP: 192.168.10.99/24
uci -q batch <<'EOF'
set network.globals=globals
set network.globals.packet_steering='1'

set network.@device[0]=device
set network.@device[0].name='br-lan'
set network.@device[0].type='bridge'
delete network.@device[0].ports
add_list network.@device[0].ports='eth0'
add_list network.@device[0].ports='eth2'

set network.lan=interface
set network.lan.device='br-lan'
set network.lan.proto='static'
set network.lan.ipaddr='192.168.10.99'
set network.lan.netmask='255.255.255.0'
set network.lan.dns='223.5.5.5'
set network.lan.delegate='0'

set network.wan=interface
set network.wan.device='eth1'
set network.wan.proto='dhcp'
delete network.wan6
commit network
EOF

# DHCP/DNS settings mirrored from the live router.
uci -q batch <<'EOF'
set dhcp.@dnsmasq[0].rebind_protection='0'
set dhcp.@dnsmasq[0].min_cache_ttl='3600'
set dhcp.@dnsmasq[0].use_stale_cache='3600'
set dhcp.@dnsmasq[0].nonegcache='1'
set dhcp.@dnsmasq[0].dns_redirect='0'
set dhcp.@dnsmasq[0].filter_aaaa='0'
set dhcp.@dnsmasq[0].filter_a='0'
set dhcp.@dnsmasq[0].noresolv='0'

set dhcp.lan=dhcp
set dhcp.lan.interface='lan'
set dhcp.lan.start='100'
set dhcp.lan.limit='150'
set dhcp.lan.leasetime='12h'
set dhcp.lan.dhcpv4='server'

set dhcp.wan=dhcp
set dhcp.wan.interface='wan'
set dhcp.wan.ignore='1'
commit dhcp
EOF

# Firewall settings from the live router.
uci -q batch <<'EOF'
set firewall.@defaults[0].input='REJECT'
set firewall.@defaults[0].output='ACCEPT'
set firewall.@defaults[0].forward='REJECT'
set firewall.@defaults[0].flow_offloading='1'
set firewall.@defaults[0].fullcone='1'
set firewall.@defaults[0].synflood_protect='1'

set firewall.@zone[0].name='lan'
set firewall.@zone[0].input='ACCEPT'
set firewall.@zone[0].output='ACCEPT'
set firewall.@zone[0].forward='ACCEPT'
delete firewall.@zone[0].network
add_list firewall.@zone[0].network='lan'

set firewall.@zone[1].name='wan'
set firewall.@zone[1].input='REJECT'
set firewall.@zone[1].output='ACCEPT'
set firewall.@zone[1].forward='REJECT'
set firewall.@zone[1].masq='1'
set firewall.@zone[1].mtu_fix='1'
delete firewall.@zone[1].network
add_list firewall.@zone[1].network='wan'
commit firewall
EOF

# Optional WireGuard restore. Create /etc/config/router-secrets after flashing:
#   WG_PRIVATE_KEY='...'
#   WG_ANDROID_PUBLIC_KEY='...'
#   WG_IOS_PUBLIC_KEY='...'
if [ -f /etc/config/router-secrets ]; then
	. /etc/config/router-secrets
	if [ -n "$WG_PRIVATE_KEY" ]; then
		uci -q batch <<EOF
set network.wg0=interface
set network.wg0.proto='wireguard'
set network.wg0.private_key='$WG_PRIVATE_KEY'
set network.wg0.listen_port='2010'
add_list network.wg0.addresses='10.0.0.1/24'
commit network
EOF
	fi
	if [ -n "$WG_ANDROID_PUBLIC_KEY" ]; then
		uci -q add network wireguard_wg0
		uci -q set network.@wireguard_wg0[-1].public_key="$WG_ANDROID_PUBLIC_KEY"
		uci -q set network.@wireguard_wg0[-1].route_allowed_ips='1'
		uci -q set network.@wireguard_wg0[-1].persistent_keepalive='25'
		uci -q set network.@wireguard_wg0[-1].description='anzhuo'
		uci -q add_list network.@wireguard_wg0[-1].allowed_ips='10.0.0.5'
		uci -q add_list network.@wireguard_wg0[-1].allowed_ips='10.0.0.2'
		uci -q add_list network.@wireguard_wg0[-1].allowed_ips='10.0.0.4'
	fi
	if [ -n "$WG_IOS_PUBLIC_KEY" ]; then
		uci -q add network wireguard_wg0
		uci -q set network.@wireguard_wg0[-1].public_key="$WG_IOS_PUBLIC_KEY"
		uci -q set network.@wireguard_wg0[-1].allowed_ips='10.0.0.3'
		uci -q set network.@wireguard_wg0[-1].route_allowed_ips='1'
		uci -q set network.@wireguard_wg0[-1].persistent_keepalive='25'
		uci -q set network.@wireguard_wg0[-1].description='pingguo'
	fi
	uci -q commit network
fi

# Keep PassWall's Xray app update channel on stable releases.
if [ -f /usr/lib/lua/luci/passwall/com.lua ]; then
	sed -i '/^_M.xray = {/,/^}/ s/get_url = gh_pre_release_url/get_url = gh_release_url/' /usr/lib/lua/luci/passwall/com.lua
fi

# Open SSH on all interfaces, matching current management style.
uci -q set dropbear.@dropbear[0].Interface=''
uci -q commit dropbear

echo "Router profile finished at $(date)" >> "$LOGFILE"
exit 0
