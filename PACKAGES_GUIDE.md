# 插件清单详解 (custom-packages.sh / apk-custom-packages.sh)

`shell/` 下两个文件的关系：

| 文件 | 适用版本 | 包格式 |
|---|---|---|
| `shell/custom-packages.sh` | LuCI 23.05.x / 24.10.x | opkg `.ipk` |
| `shell/apk-custom-packages.sh` | LuCI 25.12.x | apk `.apk` |

每一行默认都是注释（`#` 开头），打开注释（删掉行首 `#`）即在该行所列的插件被加进固件。

> ⚠️ **硬路由（闪存 16/32 MB）务必酌情打开**——加多了构建会失败或刷不进去。x86 / Rockchip 等多 GB 存储的设备没有这个限制。

---

## 一、第三方插件区（imm 仓库**外**）

这部分是 ImmortalWrt 官方仓库**没有**的，构建时会从 `wukongdaily/store`（opkg）或 `wukongdaily/apk`（apk）这两个第三方仓库拉取 `.run` 自解压包，再展开成 `.ipk` / `.apk`。

### 1.1 工具类

| 包名 | 用途 | 备注 |
|---|---|---|
| `luci-app-run` | **Run 安装器** —— 一键运行 `.run` 自解压包安装额外插件 | ⚠️ 与 quickfile 的 nginx 配置冲突，二选一 |
| `luci-i18n-quickstart-zh-cn` | **首页+网络设置向导** —— 美化的初始化引导页 | 仅 opkg 版有 |
| `bash quickfile luci-app-quickfile luci-i18n-quickfile-zh-cn` | **Quickfile 文件管理器** (by sbwml) —— 高性能 web 文件浏览/上传/下载 | ⚠️ LuCI 23 不支持，与 luci-app-run 冲突 |
| `luci-app-uninstall` | **高级卸载** (by VedioTalk) —— 比 LuCI 默认软件包页面更彻底地清除残留 | 仅 opkg 版 |
| `webdav2 luci-app-unishare` | **统一文件共享** —— 一键开启 SMB/WebDAV/FTP/AFP 等多协议共享 | 仅 opkg 版 |

### 1.2 主题类

| 包名 | 用途 | 备注 |
|---|---|---|
| `luci-theme-aurora luci-app-aurora-config luci-i18n-aurora-config-zh-cn` | **极光主题** (by eamonxg) —— 蓝紫色系，色彩鲜艳 | 仅 opkg 版 |
| `luci-theme-kucat` | **酷猫主题** (by sirpdboy) —— 蓝色系，强调可定制 | 仅 opkg 版 |

### 1.3 代理类（科学上网）

不同方案在内核架构、配置复杂度、性能上各有取舍——不要全开，**选 1-2 个就够**。

| 包名 | 用途 | 推荐场景 |
|---|---|---|
| `luci-app-openclash` | **OpenClash** (by vernesong) —— Clash 系最有名的 OpenWrt 实现，对 Clash Premium / Meta 都支持 | 老牌、订阅丰富、教程多 |
| `luci-i18n-homeproxy-zh-cn` | **HomeProxy** —— ImmortalWrt 官方力推，基于 sing-box 内核 | 官方维护、轻量、原生集成 |
| `xray-core naiveproxy luci-app-ssr-plus luci-i18n-ssr-plus-zh-cn` | **SSR Plus** —— 老牌多协议代理 (SS/SSR/V2Ray/Trojan/Hysteria) | 协议最全 |
| `xray-core sing-box hysteria luci-i18n-passwall-zh-cn` | **PassWall** (一代) —— 与 PassWall2 是不同分支 | 老用户惯用 |
| `xray-core sing-box hysteria kmod-nft-socket kmod-nft-tproxy luci-app-passwall2 luci-i18n-passwall2-zh-cn` | **PassWall2** —— PassWall 的现代重写版 | 新用户推荐 |
| `luci-i18n-daed-zh-cn` | **daed** —— dae 内核的 Web UI，基于 eBPF，性能最强 | 性能党、双栈 |
| `luci-i18n-dae-zh-cn` | **dae** —— 命令行版（无 UI） | 极客 |
| `luci-i18n-nikki-zh-cn` | **Nikki** —— 基于 Mihomo，新版 OpenWrt 推荐之一 | 新方案、轻量 |
| `clashoo luci-app-clashoo luci-i18n-clashoo-zh-cn` | **Clashoo** (by kenzok8) —— Clash 家族的另一个轻量分支 | 资源占用极小 |
| `luci-app-nekobox` | **Nekobox** —— sing-box 系的另一个面板 | 仅 opkg 版 |
| `momo luci-app-momo luci-i18n-momo-zh-cn` | **Momo** —— 极简 Mihomo 面板 | 仅 opkg 版、配置极简 |

### 1.4 VPN / 内网穿透 / 远程访问

| 包名 | 用途 | 推荐场景 |
|---|---|---|
| `luci-app-openvpn-server luci-i18n-openvpn-server-zh-cn` | **OpenVPN 服务端** —— 让外网设备拨回家里 | 兼容性好（PC/手机原生支持） |
| `luci-i18n-openvpn-zh-cn` | **OpenVPN 客户端** —— 路由器主动拨向远端 OpenVPN | 给 LAN 全员翻 |
| `luci-i18n-ipsec-vpnd-zh-cn` | **IPsec VPN 服务端** —— iOS/macOS 系统级 VPN | iPhone 原生回家 |
| `luci-proto-wireguard` | **WireGuard 协议支持** —— 现代 VPN，性能最高 | 性能党、组网首选 |
| `luci-app-tailscale-community luci-i18n-tailscale-community-zh-cn` | **Tailscale** —— 基于 WireGuard 的零配置组网 | 完全不懂网络也能用 |
| `easytier luci-app-easytier` | **EasyTier** —— 国产去中心化组网工具 | 仅 opkg 版、作为 Tailscale 替代 |
| `luci-app-lucky lucky luci-i18n-lucky-zh-cn` | **Lucky 大吉** —— DDNS + 内网穿透 + 端口转发 + Web 服务全能套件 | 多功能合一 |

### 1.5 DNS / 广告过滤

| 包名 | 用途 |
|---|---|
| `luci-app-adguardhome` | **AdGuard Home** —— 局域网 DNS 级广告过滤（仅 opkg 版） |
| `luci-app-mosdns luci-i18n-mosdns-zh-cn` | **MosDNS** —— 高性能可编程 DNS 转发（仅 opkg 版） |

### 1.6 监控 / 流量

| 包名 | 用途 | 备注 |
|---|---|---|
| `luci-app-bandix luci-i18n-bandix-zh-cn`（opkg）<br>`bandix luci-app-bandix luci-i18n-bandix-zh-cn`（apk） | **Bandix 流量监控** (by timsaya) —— 按设备/IP 实时上下行 | 跨版本 |
| `luci-app-watchdog luci-i18n-watchdog-zh-cn` | **看门狗** (by sirpdboy) —— 系统守护进程，发现异常自动重启 | 仅 opkg 版 |

### 1.7 系统 / 性能

| 包名 | 用途 | 备注 |
|---|---|---|
| `luci-app-partexp luci-i18n-partexp-zh-cn` | **分区扩容** (by sirpdboy) —— 把硬盘剩余空间扩进系统分区 | 跨版本 |
| `luci-app-advancedplus luci-i18n-advancedplus-zh-cn -luci-app-argon-config -luci-i18n-argon-config-zh-cn` | **进阶设置** (by sirpdboy) —— 各类系统调优界面 | 仅 opkg 版；与 argon 主题冲突，需带 `-` 排除 |
| `luci-app-turboacc` | **Turbo ACC** —— FastPath 网络加速（流量软硬件卸载） | 仅 opkg 版 |
| `luci-app-taskplan luci-i18n-taskplan-zh-cn` | **任务计划** —— 图形化 cron 编辑器 | 仅 opkg 版 |
| `luci-app-appfilter luci-i18n-appfilter-zh-cn` | **应用过滤** (openappfilter.com) —— 按 app 协议特征过滤（屏蔽抖音/游戏等） | 仅 opkg 版 |
| `luci-app-gecoosac gecoosac` | **集客 AC** —— 集客无线管理控制器 | 仅 opkg 版、商业品牌生态 |

### 1.8 IPTV / 媒体

| 包名 | 用途 |
|---|---|
| `luci-app-rtp2httpd luci-i18n-rtp2httpd-zh-cn` | **rtp2httpd** (by stackia) —— 把运营商 IPTV 的 RTP 组播流转 HTTP，让 Jellyfin/普通设备能直接看 |

### 1.9 文件服务

| 包名 | 用途 |
|---|---|
| `luci-i18n-dufs-zh-cn` | **dufs** —— 静态文件服务器（仅 opkg 版） |

---

## 二、官方仓库内大列表（imm 仓库**内**）

这部分都是 ImmortalWrt 官方仓库已经存在的插件，在文件 `#============以下imm仓库内的软件========` 注释行往后，按字母顺序排列。下面分类讲解，便于挑选。

### 2.1 移动 / 蜂窝网络（多用于 4G/5G 棒、ModemBand 等）

| 包名 | 用途 |
|---|---|
| `luci-i18n-3cat-zh-cn` | 3Cat 物联网模组管理 |
| `luci-i18n-3ginfo-lite-zh-cn` | 3G/4G 模组信息查看（轻量版） |
| `luci-i18n-modemband-zh-cn` | 4G 频段锁定 |
| `luci-i18n-sms-tool-js-zh-cn` | 短信收发（4G 棒） |

### 2.2 接入认证 / 校园网

| 包名 | 用途 |
|---|---|
| `luci-i18n-bitsrunlogin-go-zh-cn` | BIT 北理工校园网认证（go 版） |
| `luci-i18n-cd8021x-zh-cn` | 802.1X 客户端 |
| `luci-i18n-minieap-zh-cn` | 802.1X EAP 认证（轻量） |
| `luci-i18n-sysuh3c-zh-cn` | 中山大学 H3C 校园网 |

### 2.3 广告过滤

| 包名 | 用途 |
|---|---|
| `luci-i18n-adblock-fast-zh-cn` | AdBlock-fast 快速广告过滤 |
| `luci-i18n-adblock-zh-cn` | 经典 AdBlock |
| `luci-i18n-banip-zh-cn` | IP 黑名单（按国家/地区/单 IP 屏蔽） |

### 2.4 DNS

| 包名 | 用途 |
|---|---|
| `luci-i18n-https-dns-proxy-zh-cn` | DoH 客户端（DNS over HTTPS） |
| `luci-i18n-nextdns-zh-cn` | NextDNS（带广告过滤的云 DNS） |
| `luci-i18n-smartdns-zh-cn` | **SmartDNS**（推荐）—— 本地高性能 DNS，双栈 + 测速 |
| `luci-i18n-unbound-zh-cn` | Unbound 递归 DNS 服务器 |
| `luci-i18n-omcproxy-zh-cn` | IPv6 组播代理 |

### 2.5 SSL / 证书

| 包名 | 用途 |
|---|---|
| `luci-i18n-acme-zh-cn` | **ACME**（推荐）—— 自动签发 Let's Encrypt 证书 |

### 2.6 升级 / 维护

| 包名 | 用途 |
|---|---|
| `luci-i18n-attendedsysupgrade-zh-cn` | **保留配置升级**（强烈推荐）—— web 一键升级且保留所有插件配置 |
| `luci-i18n-advanced-reboot-zh-cn` | 高级重启（双分区设备切换 firmware） |
| `luci-i18n-autoreboot-zh-cn` | 定时自动重启 |
| `luci-i18n-watchcat-zh-cn` | Watchcat —— 检测断网自动重启 WAN/系统 |

### 2.7 多 WAN / QoS / 加速

| 包名 | 用途 |
|---|---|
| `luci-i18n-mwan3-zh-cn` | **mwan3** —— 多 WAN 负载均衡 / 主备 |
| `luci-i18n-sqm-zh-cn` | **SQM**（推荐）—— 智能队列 (CAKE 算法)，治理网游卡顿 |
| `luci-i18n-qos-zh-cn` | 传统 QoS |
| `luci-i18n-nft-qos-zh-cn` | nftables QoS |
| `luci-i18n-eqos-zh-cn` | eqos 简易限速（按 IP） |
| `luci-i18n-irqbalance-zh-cn` | IRQ 平衡（多核 CPU 分摊网卡中断） |

### 2.8 流量统计

| 包名 | 用途 |
|---|---|
| `luci-i18n-nlbwmon-zh-cn` | nlbwmon —— 按设备记账，月报表 |
| `luci-i18n-vnstat2-zh-cn` | vnStat2 —— 历史流量曲线 |
| `luci-i18n-statistics-zh-cn` | collectd + RRD 统计图表 |
| `luci-i18n-netdata-zh-cn` | **Netdata**（推荐）—— 实时性能监控大盘，最美观 |
| `luci-i18n-dashboard-zh-cn` | 简易性能仪表盘 |

### 2.9 代理 / 翻墙

| 包名 | 用途 |
|---|---|
| `luci-i18n-pbr-zh-cn` | **PBR**（推荐）—— Policy-Based Routing 策略路由，做分流 |
| `luci-i18n-v2raya-zh-cn` | v2rayA —— v2ray 的轻量 web 面板 |
| `luci-i18n-tor-zh-cn` | Tor 洋葱路由 |
| `luci-i18n-microsocks-zh-cn` | Microsocks 轻量 SOCKS5 |
| `luci-i18n-tinyproxy-zh-cn` | Tinyproxy 轻量 HTTP 代理 |
| `luci-i18n-privoxy-zh-cn` | Privoxy HTTP 代理（带过滤） |
| `luci-i18n-squid-zh-cn` | Squid HTTP 代理（带缓存） |
| `luci-i18n-haproxy-tcp-zh-cn` | HAProxy TCP 转发 |
| `luci-i18n-gost-zh-cn` | GOST 多协议隧道 |
| `luci-i18n-sshtunnel-zh-cn` | SSH 隧道 |
| `luci-i18n-fwknopd-zh-cn` | Port Knocking 端口敲门 |

### 2.10 VPN / 内网穿透

| 包名 | 用途 |
|---|---|
| `luci-i18n-zerotier-zh-cn` | ZeroTier —— 零配置组网 |
| `luci-i18n-frpc-zh-cn` | FRP 客户端 |
| `luci-i18n-frps-zh-cn` | FRP 服务端 |
| `luci-i18n-xfrpc-zh-cn` | xfrpc —— 轻量 FRP 客户端 |
| `luci-i18n-ngrokc-zh-cn` | ngrok 客户端 |
| `luci-i18n-nps-zh-cn` | NPS —— 国产内网穿透 |
| `luci-i18n-natmap-zh-cn` | NATMap —— Full-cone NAT 端口探测 |
| `luci-i18n-n2n-zh-cn` | N2N 点对点 VPN |
| `luci-i18n-eoip-zh-cn` | EoIP 二层 VPN |
| `luci-i18n-softethervpn-zh-cn` | SoftEther VPN —— 多协议 VPN（日本筑波大学） |
| `luci-i18n-ocserv-zh-cn` | OpenConnect Server (Cisco AnyConnect 兼容) |

### 2.11 DDNS

| 包名 | 用途 |
|---|---|
| `luci-i18n-ddns-zh-cn` | 经典 DDNS |
| `luci-i18n-ddns-go-zh-cn` | **DDNS-Go**（推荐）—— go 版重写，配置极简 |

### 2.12 文件共享 / 网盘

| 包名 | 用途 |
|---|---|
| `luci-i18n-samba4-zh-cn` | Samba4 SMB（用户态） |
| `luci-i18n-ksmbd-zh-cn` | **ksmbd** SMB（内核态，性能更好） |
| `luci-i18n-nfs-zh-cn` | NFS（Linux 友好） |
| `luci-i18n-vsftpd-zh-cn` | vsftpd FTP 服务端 |
| `luci-i18n-cifs-mount-zh-cn` | CIFS/SMB 客户端挂载远端 |
| `luci-i18n-openlist-zh-cn` | **OpenList**（推荐）—— 网盘聚合（百度/阿里/123/OneDrive 等） |
| `luci-i18n-rclone-zh-cn` | Rclone —— 命令行网盘同步神器 |
| `luci-i18n-syncthing-zh-cn` | Syncthing —— 个人版 Dropbox |
| `luci-i18n-radicale-zh-cn` | Radicale CalDAV/CardDAV 服务器 |
| `luci-i18n-filebrowser-go-zh-cn` | File Browser (go 版) —— web 文件管理器 |
| `luci-i18n-filebrowser-zh-cn` | File Browser 经典版 |
| `luci-i18n-filemanager-zh-cn` | 简易 web 文件管理器（默认已装） |
| `luci-i18n-ps3netsrv-zh-cn` | PS3 网络存储 |
| `luci-i18n-ser2net-zh-cn` | Serial-to-Network（串口转 TCP） |

### 2.13 下载工具

| 包名 | 用途 |
|---|---|
| `luci-i18n-aria2-zh-cn` | Aria2 多协议下载（搭配 AriaNg） |
| `luci-i18n-qbittorrent-zh-cn` | qBittorrent BT 下载 |
| `luci-i18n-transmission-zh-cn` | Transmission BT |
| `luci-i18n-amule-zh-cn` | aMule 电驴 |
| `luci-i18n-xlnetacc-zh-cn` | 迅雷快鸟（已基本失效） |

### 2.14 多媒体

| 包名 | 用途 |
|---|---|
| `luci-i18n-airplay2-zh-cn` | AirPlay2 服务（让路由器变 AirPlay 接收器） |
| `luci-i18n-minidlna-zh-cn` | miniDLNA 媒体服务器 |
| `luci-i18n-mjpg-streamer-zh-cn` | mjpg-streamer USB 摄像头流推送 |
| `luci-i18n-music-remote-center-zh-cn` | 音乐遥控中心 |
| `luci-i18n-spotifyd-zh-cn` | Spotifyd Spotify Connect 接收器 |
| `luci-i18n-msd_lite-zh-cn` | msd_lite 多源直播流转发 |
| `luci-i18n-udpxy-zh-cn` | udpxy IPTV 组播转单播 |
| `luci-i18n-dump1090-zh-cn` | dump1090 ADS-B 飞机信号接收 |

### 2.15 物联网 / 模组

| 包名 | 用途 |
|---|---|
| `luci-i18n-mosquitto-zh-cn` | Mosquitto MQTT Broker |
| `luci-i18n-music-remote-center-zh-cn` | 音乐遥控中心 |
| `luci-i18n-rustdesk-server-zh-cn` | RustDesk Server —— 自建远程桌面中继 |
| `luci-i18n-oled-zh-cn` | OLED 屏显示路由器状态 |
| `luci-i18n-battstatus-zh-cn` | 电池状态显示（部分硬件） |
| `luci-i18n-nut-zh-cn` | NUT —— UPS 不间断电源监控，掉电自动关机 |

### 2.16 防火墙 / 安全

| 包名 | 用途 |
|---|---|
| `luci-i18n-bcp38-zh-cn` | BCP38 反 IP 欺骗规则 |
| `luci-i18n-crowdsec-firewall-bouncer-zh-cn` | CrowdSec —— 社区驱动入侵检测 |
| `luci-i18n-cshark-zh-cn` | Cloudshark —— 远程抓包到云端 |
| `luci-i18n-acl-zh-cn` | LuCI ACL 权限管理 |
| `luci-i18n-arpbind-zh-cn` | ARP 绑定（防 ARP 欺骗） |

### 2.17 PPPoE 服务端 / 二级路由

| 包名 | 用途 |
|---|---|
| `luci-i18n-pppoe-server-zh-cn` | PPPoE 服务端（Linux 实现） |
| `luci-i18n-pppoe-relay-zh-cn` | PPPoE 中继 |
| `luci-i18n-rp-pppoe-server-zh-cn` | rp-pppoe 服务端（功能更全） |

### 2.18 无线 / Mesh

| 包名 | 用途 |
|---|---|
| `luci-i18n-usteer-zh-cn` | **Usteer**（推荐）—— 多 AP 漫游优化 |
| `luci-i18n-dawn-zh-cn` | DAWN —— 802.11k/v/r 漫游决策器 |
| `luci-i18n-wifischedule-zh-cn` | WiFi 定时开关 |
| `luci-i18n-coovachilli-zh-cn` | CoovaChilli 公共热点认证（咖啡馆/酒店式） |
| `luci-i18n-splash-zh-cn` | 公共热点 Splash 页面 |
| `luci-i18n-travelmate-zh-cn` | **Travelmate** —— 让路由器作为 wifi 客户端连接公共热点（旅途场景） |
| `luci-i18n-dcwapd-zh-cn` | 双频道无线接入点 |

### 2.19 路由协议（专业 / 实验性）

| 包名 | 用途 |
|---|---|
| `luci-i18n-bmx7-zh-cn` | BMX7 mesh 路由协议 |
| `luci-i18n-olsr-zh-cn` | OLSR 协议 |
| `luci-i18n-olsr-services-zh-cn` | OLSR 服务发现 |
| `luci-i18n-olsr-viz-zh-cn` | OLSR 可视化 |
| `luci-i18n-pagekitec-zh-cn` | PageKite 客户端 |
| `luci-i18n-openwisp-zh-cn` | OpenWISP 集中管理 |
| `luci-i18n-dynapoint-zh-cn` | DynaPoint 自适应 SSID |

### 2.20 系统工具

| 包名 | 用途 |
|---|---|
| `luci-i18n-diskman-zh-cn` | DiskMan 磁盘管理（默认已装） |
| `luci-i18n-hd-idle-zh-cn` | hd-idle —— 硬盘空闲休眠 |
| `luci-i18n-ramfree-zh-cn` | 一键释放内存 |
| `luci-i18n-cpulimit-zh-cn` | 限制单进程 CPU 占用 |
| `luci-i18n-ttyd-zh-cn` | ttyd 网页终端（默认已装） |
| `luci-i18n-uhttpd-zh-cn` | uhttpd web 服务器配置 |
| `luci-i18n-commands-zh-cn` | LuCI 自定义命令按钮 |
| `luci-i18n-email-zh-cn` | 邮件发送（系统通知） |
| `luci-i18n-wechatpush-zh-cn` | 微信/企微推送 |
| `luci-i18n-snmpd-zh-cn` | SNMP 服务（被网管软件读取） |
| `luci-i18n-clamav-zh-cn` | ClamAV 防病毒 |
| `luci-i18n-lldpd-zh-cn` | LLDP 链路层发现 |
| `luci-i18n-keepalived-zh-cn` | Keepalived 双机热备 |
| `luci-i18n-xinetd-zh-cn` | xinetd 超级服务器 |
| `luci-i18n-natmap-zh-cn` | NAT 类型探测 |

### 2.21 网络唤醒

| 包名 | 用途 |
|---|---|
| `luci-i18n-wol-zh-cn` | 网络唤醒（手动 web 按钮） |
| `luci-i18n-timewol-zh-cn` | 定时网络唤醒 |

### 2.22 UPnP / 端口

| 包名 | 用途 |
|---|---|
| `luci-i18n-upnp-zh-cn` | UPnP（游戏机/BT 自动开端口） |

### 2.23 USB 周边

| 包名 | 用途 |
|---|---|
| `luci-i18n-usb-printer-zh-cn` | USB 打印机共享 |
| `luci-i18n-p910nd-zh-cn` | p910nd —— 简易打印服务器 |

### 2.24 容器 / 虚拟化

| 包名 | 用途 |
|---|---|
| `luci-i18n-lxc-zh-cn` | LXC Linux 容器 |

### 2.25 运营商 / Linux 桌面 / 杂项

| 包名 | 用途 |
|---|---|
| `luci-i18n-cloudflared-zh-cn` | **Cloudflared**（推荐）—— Cloudflare Tunnel 客户端 |
| `luci-i18n-vlmcsd-zh-cn` | vlmcsd —— 本地 KMS 服务器（激活 Win/Office） |
| `luci-i18n-oscam-zh-cn` | OSCAM 收费电视卡共享 |
| `luci-i18n-ua2f-zh-cn` | **UA2F** —— 篡改 HTTP UA 绕过运营商热点检测 |
| `luci-i18n-dsl-zh-cn` | DSL 调制解调器 |
| `luci-i18n-example-zh-cn` | LuCI 开发示例（无实际用途） |

---

## 三、常见组合推荐

按使用场景挑选，每个场景都建议**只选一组**，加多了硬路由会塞不下、软路由也会拖慢启动。

### 3.1 纯路由用户（家庭多设备 + 偶尔 BT/网盘）

```bash
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-attendedsysupgrade-zh-cn"   # 升级保配置
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-ddns-go-zh-cn"              # 家宽 IP → 域名
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-smartdns-zh-cn"             # 聪明 DNS
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-sqm-zh-cn"                  # 缓解游戏卡顿
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-partexp luci-i18n-partexp-zh-cn"  # 扩容
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-bandix luci-i18n-bandix-zh-cn"    # 流量监控
```

### 3.2 科学上网用户（任选一种代理方案 + 分流）

```bash
# 三选一：
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openclash"
# 或
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-homeproxy-zh-cn"
# 或
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-daed-zh-cn"

# 配合分流：
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-pbr-zh-cn"
```

### 3.3 远程访问家里

```bash
# 简单：
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-tailscale-community luci-i18n-tailscale-community-zh-cn"

# 性能：
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-proto-wireguard"

# iPhone 原生回家：
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-ipsec-vpnd-zh-cn"
```

### 3.4 NAS / 文件服务器

```bash
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-ksmbd-zh-cn"        # SMB（高性能）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-openlist-zh-cn"     # 网盘聚合
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-syncthing-zh-cn"    # 同步
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-rclone-zh-cn"       # 命令行同步
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-aria2-zh-cn"        # 下载
```

### 3.5 IPTV 家庭

```bash
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-rtp2httpd luci-i18n-rtp2httpd-zh-cn"
```

---

## 四、加包注意事项

1. **保持 opkg 与 apk 两个文件同步**：如果你的改动既适用 24.x 又适用 25.x，两个文件都要改，否则只改一个会让另一边的版本"漏装"。
2. **冲突检测**：
   - `luci-app-run` 与 `quickfile` 系列冲突（nginx 配置打架）
   - `luci-app-advancedplus` 与 argon-config 冲突（用 `-luci-app-argon-config -luci-i18n-argon-config-zh-cn` 排除）
   - 多个代理同时装可以，但运行时只能开一个，否则规则互相打架
3. **硬路由 16/32MB flash 设备**：基本只能开 1-2 个第三方插件，建议 BUILD 之前先空腔预估。
4. **构建报错 "package not found"**：大概率是包名拼错了，或者该包仅在某一版本可用（如 `luci-i18n-package-manager-zh-cn` 仅 25.x 才有）。
5. **构建后固件过大**：调小 `apk-custom-packages.sh` 注释开关数量，或在工作流表单提高 `rootfs_partsize`。

---

## 五、定位某个包的官方说明

- ImmortalWrt 官方仓库索引（24.10 x86_64）：https://mirrors.sjtug.sjtu.edu.cn/immortalwrt/releases/24.10.4/packages/x86_64/luci/
- 第三方 store（opkg）：https://github.com/wukongdaily/store
- 第三方 apk：https://github.com/wukongdaily/apk
- 集成方法说明：https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209
