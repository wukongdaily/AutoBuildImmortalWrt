# ImmortalWrt 自动构建系统

**⚠️ 重要声明**

> **本项目为个人独立维护的第三方项目（脚本），与 ImmortalWrt 官方没有关联。** <br>
> **项目中使用了 ImmortalWrt 官方 ImageBuilder 工具打包生成固件。<br>
> 但用户自行定制产生的任何 bug，均不代表 ImmortalWrt 官方固件的 bug**<br>
> **为了不给 ImmortalWrt 上游维护者增加额外负担和麻烦，所有相关问题请勿在 ImmortalWrt 群内反馈**。  <br>
> **建议各位在本项目 [Discussions](https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions) 中提问或讨论**

---

[![GitHub](https://img.shields.io/github/license/wukongdaily/AutoBuildImmortalWrt.svg?label=LICENSE&logo=github&logoColor=%20)](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&logo=appveyor&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&logo=appveyor&label=Forks&logo=github)

[新手指导 Wiki](https://github.com/wukongdaily/AutoBuildImmortalWrt/wiki) | [支持的机型列表](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/SUPPORT.md) | [第三方插件仓库](https://github.com/wukongdaily/store) | [问题反馈](https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions)

---

## 一、这是什么？

这是一个基于 GitHub Actions 的 **ImmortalWrt 固件自动构建系统**。你只需要在网页上点击几下，就能自动生成包含各种插件的路由器固件，无需任何编程知识。

**支持的版本：**
- 24.10.x（使用 opkg/ipk 包管理器，插件生态最完善）
- 25.12.x（使用 apk 包管理器，部分第三方插件暂不支持）

**支持的平台：**
- x86-64（软路由、虚拟机）
- x86-64 ISO（可安装到物理机/虚拟机）
- Rockchip（如 RK3568、RK3588）
- ARM64（如斐讯 N1）

---

## 二、快速开始（3步完成）

### 第1步：Fork 项目

1. 打开本项目页面：https://github.com/wukongdaily/AutoBuildImmortalWrt
2. 点击右上角 **Fork** 按钮，将项目复制到你的 GitHub 账号下

### 第2步：触发构建

1. 在你的 Fork 项目中，点击顶部 **Actions** 选项卡
2. 左侧列表选择对应的工作流：
   - `build-x86-64-immortalwrt-24.10.x`（推荐，插件支持最全）
   - `build-x86-64-immortalwrt-25.12.x`（新版，部分插件不支持）
   - `build-x86-64-immortalwrt-24.10.x-iso`（虚拟机/物理机安装器）
3. 点击右侧绿色按钮 **Run workflow**
4. 填写参数（详见下方参数说明）
5. 点击 **Run workflow** 开始构建

### 第3步：下载固件

1. 构建完成后（约20-40分钟），点击左侧 **Releases**
2. 下载对应固件文件：
   - x86-64：`openwrt-x86-64-*-squashfs-combined-efi.img.gz`
   - ISO：`openwrt-x86-64-*-squashfs-combined-efi.iso`

---

## 三、工作流参数说明

### 基础参数

| 参数 | 说明 | 推荐值 |
|------|------|--------|
| LuCI 版本 | ImmortalWrt 版本号 | 24.10.6（最新稳定版） |
| 固件大小 | 固件分区大小（MB） | 1024（1GB，够用） |
| 管理地址 | 路由器后台 IP（仅多网口有效） | 192.168.100.1 |
| Docker | 是否预装 Docker 容器引擎 | 根据需要选择 |
| iStore 商店 | 是否预装 iStore 应用商店 | 24.10 可选，25.12 不支持 |
| PPPoE 拨号 | 是否配置宽带拨号 | 需要拨号选 yes |

### 插件预设方案

| 预设 | 包含的插件 | 适用场景 |
|------|-----------|----------|
| **自定义** | 你手动勾选的复选框 | 需要精细控制 |
| **精简版** | 极光主题 + 文件管理器 + 高级卸载 | 轻量使用 |
| **标准版** | 精简版 + PassWall + MosDNS + TurboACC + 分区扩容 | 日常使用 |
| **全家桶** | 标准版 + PassWall2 + OpenClash + SSR-Plus + Nikki + Clashoo + AdGuardHome + Tailscale + Easytier + Lucky + Bandix | 功能最全 |

**重要说明：**

> **预设方案会覆盖下方所有复选框的设置。** <br>
> 例如：选择"全家桶"后，无论下方复选框是否勾选，都会安装全家桶包含的所有插件。<br>
> 只有选择"自定义"时，下方的复选框勾选状态才会生效。
>
> **这是 GitHub Actions 平台的技术限制：下拉菜单和复选框无法自动联动。** <br>
> UI 上的复选框状态仅作为参考，实际编译内容由预设方案决定。

### 可选插件列表（自定义模式下生效）

**代理工具：**
- PassWall（经典版，含 xray/singbox/ss/ssr/trojan）
- PassWall2（新版，含 xray/sing-box/hysteria）
- OpenClash（含 clash_meta 内核，体积较大）
- SSR-Plus（含 mihomo 内核）
- Nikki、Clashoo

**DNS/去广告：**
- MosDNS（高性能 DNS 分流）
- AdGuardHome（本地 DNS 去广告）

**网络/加速/组网：**
- TurboACC（网络加速，含 BBR/shortcut）
- Tailscale VPN（基于 WireGuard）
- Easytier（组网工具）

**主题：**
- 极光 Aurora Theme（默认开启）

**实用工具：**
- Lucky 大吉（端口转发/反向代理/NAT）
- QuickFile（文件管理器）
- 高级卸载（彻底删除插件）
- 分区扩容（扩展固件空间）
- Bandix（流量监控）

---

## 四、构建出来的固件包含什么？

### 默认预装（所有预设方案都有）

**系统基础：**
- ImmortalWrt 完整系统（基于 OpenWrt 的中国定制版）
- LuCI Web 管理界面（中文）
- SSH 服务（dropbear）
- DHCP/DNS 服务（dnsmasq-full）
- 防火墙（nftables）
- PPPoE 拨号支持
- IPv6 支持

**网卡驱动（x86-64）：**
- Intel 系列：e1000、e1000e、igb、igc、ixgbe、i40e、vmxnet3
- Realtek 系列：r8168、r8125、r8126、r8101
- Broadcom：tg3

**预装应用：**
- Argon 主题 + 极光 Aurora 主题
- 磁盘管理器（DiskMan）
- 文件管理器（FileManager）
- 网页终端（TTYD）
- SFTP 服务
- 软件包管理器
- 防火墙管理
- SNMP 管理（用于爱快三层管理）

### 单网口设备特别说明

单网口设备（如 NAS）刷入后采用 **WAN+LAN 混合模式**：
- 路由器通过 DHCP 从上级设备获取 IP（作为 WAN）
- 同时自身提供 DHCP 服务（作为 LAN）
- 默认不下发 IPv6 地址（获取但不下发）
- 需要从上级路由器查看分配的 IP 来访问后台

### 多网口设备说明

- WAN 口（eth0）：DHCP 或 PPPoE 拨号
- LAN 口：默认 IP 为 `192.168.100.1`（可在工作流中自定义）
- 其余网口均为 LAN

---

## 五、刷机使用

### 虚拟机（推荐使用 ISO）

1. 构建时选择 `x86-64-iso` 工作流
2. 下载 ISO 文件
3. 创建虚拟机，挂载 ISO 启动
4. 跑码结束后，在命令行输入 `ddd` 按提示安装
5. 安装完成后重启，移除 ISO，从硬盘启动

### 物理机（EFI 启动）

**方法一：ISO 安装器（推荐）**
1. Windows：用 [Ventoy](https://www.ventoy.net/cn/index.html) 制作启动 U 盘，将 ISO 拷贝到 U 盘
2. macOS：用 [balenaEtcher](https://etcher.balena.io/) 将 ISO 刻录到 U 盘
3. 插入 U 盘，重启电脑，按 Del/F12/F11/F7 选择 U 盘启动
4. 命令行输入 `ddd` 按提示安装到硬盘

**方法二：直接写盘**
1. 用 Rufus/balenaEtcher 将 `.img.gz` 文件写入 U 盘
2. 从 U 盘启动即可运行

### 首次登录

1. **管理地址：**
   - 多网口设备：`192.168.100.1`（或你自定义的 IP）
   - 单网口设备：在上级路由器的 DHCP 列表中查看分配的 IP
2. **用户名：** `root`
3. **密码：** 空（无密码）
4. **SSH：** 已开放

---

## 六、重要配置提醒

### 防火墙安全设置

固件默认开启了 WAN 口入站（为了首次调试方便）。**调试完毕后务必关闭：**

1. 登录后台 → 网络 → 防火墙
2. WAN 的入站选择 **拒绝**
3. 保存并应用

### 旁路由用户必读

- 旁路由应该使用**单网口模式**
- 单网口默认采用 DHCP 模式，从上级路由器获取 IP
- 在上级路由器查看分配的 IP，用该 IP 访问后台
- 在后台中自行配置旁路由的静态 IP

### 25.12 版本限制

25.12 使用 apk 包管理器，以下插件暂不支持：
- MosDNS、iStore 商店、高级卸载、vssr

---

## 七、常见问题

### Q：为什么选了全家桶，复选框没有自动勾选？

**A：这是 GitHub Actions 平台的技术限制。** 下拉菜单和复选框是完全独立的输入控件，无法自动联动。但不用担心，选择预设方案后，工作流脚本会自动覆盖所有复选框设置。例如选"全家桶"，脚本会强制安装全家桶包含的所有插件，无论复选框是否勾选。

### Q：24.10 和 25.12 怎么选？

**A：推荐使用 24.10**，插件生态最完善。25.12 是新版，但部分第三方插件还未适配。

### Q：固件大小设多少合适？

**A：默认 1024MB（1GB）够用。** 如果要装很多插件或 Docker，可以设 1500-2000。后期可通过分区扩容插件调整。

### Q：构建失败怎么办？

**A：** 
1. 检查 Actions 页面的错误日志
2. 确认选择的插件在对应版本中存在
3. 如遇问题，在 [Discussions](https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions) 提问

### Q：如何更新插件？

**A：** 构建完成后，如需追新插件，可使用 [RunFilesBuilder](https://github.com/wukongdaily/RunFilesBuilder) 项目生成 `.run` 文件，通过 `sh xx.run` 命令覆盖安装。

---

## 八、插件仓库查询

- **ImmortalWrt 官方插件：** https://mirrors.sjtug.sjtu.edu.cn/immortalwrt/releases/24.10.4/packages/x86_64/luci/
- **第三方插件列表：** https://github.com/wukongdaily/store
- **集成第三方插件方法：** https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209

---

## 九、视频教程

- [虚拟机安装 ISO 教学](https://www.bilibili.com/video/BV1enxMzwEUe/)
- [绿联 NAS 安装 ImmortalWrt 25.12](https://www.bilibili.com/video/BV1AyZcBsErt/)
- [物理机安装 ISO 教学](https://www.bilibili.com/video/BV1DQXVYFENr/?t=826)（精准空降到 13:46）
- [集成第三方插件教学](https://www.youtube.com/watch?v=KN6AJYV1hBI)

---

## 十、相关项目

- [一键生成 run 插件](https://github.com/wukongdaily/RunFilesBuilder)
- [一键生成 Docker 离线镜像](https://github.com/wukongdaily/DockerTarBuilder)
- [OpenWrt/Armbian IMG 安装器 ISO](https://github.com/wukongdaily/img-installer)
- [固件下载加速站](https://wkdaily.cpolar.top/archives/1)

---

## 鸣谢

- https://github.com/immortalwrt
- https://github.com/ophub/flippy-openwrt-actions
- https://github.com/ophub/amlogic-s9xxx-openwrt
- https://github.com/sirpdboy
- https://github.com/wukongdaily/ib-overlay
- 高级卸载插件出处 by VedioTalk https://xz.vumstar.com
- 极光主题 https://github.com/eamonxg/luci-theme-aurora
- Bandix 流量监控 https://github.com/timsaya/luci-app-bandix
- rtp2httpd https://github.com/stackia/rtp2httpd

---

<details>
<summary><h2>相关引用</h2></summary>

#### 引用和项目参考的仓库
- https://github.com/wukongdaily/RunFilesBuilder
- https://github.com/wukongdaily/store
- https://github.com/sirpdboy/luci-theme-kucat
- https://github.com/AdguardTeam/AdGuardHome
- https://github.com/kiddin9/kwrt-packages
</details>
