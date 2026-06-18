# Router Profile

This fork is tailored for the current ESXi ImmortalWrt router.

## Source Router

- System: ImmortalWrt 24.10.4 x86/64
- Host role: ESXi virtual router
- LAN IP: 192.168.10.99
- LAN bridge: eth0 + eth2
- WAN: eth1, DHCP
- DNS on LAN interface: 223.5.5.5
- Current disk: 2 GB virtual disk
- Current overlay: /dev/sda3 f2fs extroot, about 1.7 GB

## Build Defaults

- Use x86-64 24.10.x workflow.
- Default version should stay on 24.10.4 unless intentionally testing newer releases.
- Default rootfs size is 2048 MB for ESXi.
- Docker is disabled by default.
- PPPoE is disabled by default because the live router WAN uses DHCP.

## Included Runtime Stack

- PassWall with stable Xray update channel
- xray-core
- sing-box
- hysteria
- chinadns-ng
- haproxy
- geoview
- ipt2socks, dns2socks, microsocks
- WireGuard packages
- ddns-go
- vlmcsd
- f2fs and partition tools

## Secrets Not Committed

The following are intentionally not committed:

- PassWall nodes, subscriptions, UUIDs, paths, passwords, SNI, hosts
- WireGuard private key
- SSH private keys
- Cloud or DDNS tokens
- PPPoE credentials

Restore those after flashing from a private backup or GitHub Secrets.
