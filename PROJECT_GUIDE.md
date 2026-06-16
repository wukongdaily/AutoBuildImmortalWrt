# ImmortalWrt-ImageBuilder 项目说明

## 一、这个项目是干什么的？

简单一句话：**这是一个跑在 GitHub Actions 上的"在线固件定制工厂"**。你不用装 Linux、不用拉源码、不用等几小时编译，只要在网页上点几下，半小时内就能拿到一个属于自己的 ImmortalWrt 路由器固件。

### 它的工作原理

它**不是**从零编译 OpenWrt 源码，而是用 ImmortalWrt 官方提供的 **ImageBuilder**（预编译工具包）。
ImageBuilder 就像"乐高底座"——官方已经把内核和基础组件编译好了，你只需要决定：

- 要哪些插件（科学上网、Docker 管理、主题美化、文件管理器…）
- 给多大的存储空间（默认 1024 MB）
- 要不要预设宽带拨号账号
- 路由器的默认管理 IP 是多少

工厂收到订单后，把这些选择拼装成一份完整的固件镜像，传到 GitHub Releases 里给你下载。

### 支持的设备

通过 `.github/workflows/` 里不同的工作流来覆盖不同硬件：

| 工作流 | 适用设备 |
|---|---|
| `build-x86-64-*.yml` | **软路由 / 虚拟机 / 工控机**（最常用）|
| `build-iso-*.yml` | **想用 U 盘安装到物理机的 x86 用户**（独有功能，输出 ISO 安装器）|
| `build-rockchip-*.yml` | RK3328 / RK3399 / RK3568 等开发板（友善 R 系列、香橙派等）|
| `build-sunxi-cortexa53-*.yml` | 全志 H5 / H6 / H616 系列开发板 |
| `build-mediatek-filogic` 相关 | 联发科 Filogic 平台 |
| `build-RaspBerryPi-*.yml` | 树莓派 |
| `build-N1.yml` | 斐讯 N1 盒子 |
| `build-wireless-router*.yml` | 普通无线路由器（mt7621、ipq807x、bcm53xx 等）|
| `build-QEMU-arm64-*.yml` | QEMU ARM64 虚拟机镜像 |

> 注意：文件名里的 `23` / `24` / `25` 对应 ImmortalWrt 的 LuCI 大版本（23.05.x / 24.10.x / 25.12.x）。25.x 改用了新的 apk 包管理器，23/24 还是 opkg——这就是为什么 `shell/` 下既有 `custom-packages.sh` 又有 `apk-custom-packages.sh`。

---

## 二、怎么用？（小白完整流程）

### 步骤 1：Fork 本仓库到你自己的 GitHub 账号

打开仓库页面，右上角点 **Fork** —— 这一步必须做。GitHub Actions 不会在原仓库里替你跑构建；它只在**你自己的 fork** 里跑。

### 步骤 2：在 fork 里启用 Actions

第一次打开 Fork 后的 Actions 标签时，GitHub 会显示一个黄色提示：
> "Workflows aren't being run on this forked repository"

点蓝色按钮 **"I understand my workflows, go ahead and enable them"**。

### 步骤 3：选择对应你设备的工作流

在 **Actions** 页面左侧列表里找到要用的那个，比如：
- 软路由/虚拟机 → `build-x86-64-immortalwrt-25.12.x`
- 物理机想用 U 盘 ISO 安装 → `build 25.12.x ISO`
- RK3568 之类的 → `build-rockchip-immortalwrt-25.12.x`

### 步骤 4：点击 "Run workflow" 填表

右上角会出现一个 **Run workflow** 下拉按钮，点开后是这样一份表：

| 字段 | 含义 | 建议值 |
|---|---|---|
| **luci_version** | ImmortalWrt 子版本 | 选最新的稳定版（如 `25.12.0`）|
| **custom_router_ip** | 路由器后台 IP（仅多网口生效）| 默认 `192.168.100.1`，改成跟你主路由不冲突的网段，比如 `192.168.80.1` |
| **profile** | 固件 ROOT 分区大小（MB）| `1024` 够大多数人用；插件多可以 `2048`。**不建议设过大**，超过实际硬盘没意义 |
| **include_docker** | 是否预装 Docker 管理插件 | 想跑容器选 `yes`，纯路由用选 `no` 省空间 |
| **enable_pppoe** | 是否预设宽带拨号 | 拨号上网选 `yes` 并填账号密码；光猫桥接没拨号选 `no` |
| **pppoe_account / password** | 宽带账号密码 | 仅当上一项是 `yes` 时填 |

填好后点绿色的 **Run workflow** 按钮，构建开始。

### 步骤 5：等待构建完成

通常 5–15 分钟（ISO 工作流 7–8 分钟）。你可以点进运行实例看实时日志。**绿色对勾 ✅** 表示成功。

### 步骤 6：下载固件

构建完成后，进入仓库的 **Releases** 页面（不是 Actions 里的 Artifacts，而是真正的 Releases）。
对应 tag 下挂着固件文件：
- x86-64 标准固件：`*-squashfs-combined-efi.img.gz`（约 200 MB 左右）
- ISO 安装器：`custom-installer-x86_64.iso`
- 其他平台：`.img.gz` / `.tar.gz` / 各厂商专用格式

下载到本地。

### 步骤 7：刷入设备

不同硬件方法不同，这里只列最常见的两种：

**虚拟机（PVE / ESXi / VMware / VirtualBox）**
- 推荐直接用 ISO 工作流出的 ISO，挂载光驱启动；
- 启动后命令行输入 `ddd`，按提示选磁盘安装。

**物理软路由 / 工控机**
- 用 [balenaEtcher](https://etcher.balena.io/) 把 `.img.gz`（先解压成 `.img`）写进 U 盘 → U 盘启动 → DD 到硬盘；
- 或者用本项目独有的 ISO 安装器：把 ISO 用 [Ventoy](https://www.ventoy.net/cn/index.html) 拷到 U 盘，启动后输入 `ddd` 引导安装（**优势：装完硬盘剩余空间能继续用，不像传统 DD 会浪费**）。

### 步骤 8：首次访问

刷完启动后：
- **多网口设备**：浏览器访问你在表单里填的 `custom_router_ip`（默认 `192.168.100.1`），用户名 `root`，**无密码**。
- **单网口设备**：固件默认 DHCP，先接到上级路由器，去上级后台看分给它什么 IP，再访问那个 IP。

---

## 三、进阶用法

### 想加额外的插件（科学上网、广告过滤、主题等）

编辑 `shell/custom-packages.sh`（apk 版 25.x 编辑 `shell/apk-custom-packages.sh`），文件里有一长串**已经写好但被注释掉**的行，比如：

```bash
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openclash"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-theme-aurora luci-app-aurora-config luci-i18n-aurora-config-zh-cn"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adguardhome"
```

把行首的 `#` 删掉就启用了，commit 推到你的 fork，下次构建就会带上这些插件。

> ⚠️ 硬路由（闪存只有 16/32 MB 的）小心别开太多，会构建失败或刷不进去。
> ⚠️ 加默认仓库**之外**的第三方插件需要它本身存在（参考 `wukongdaily/store` 仓库），随便写一个不存在的包名会让构建报错。

### 想改固件首次启动行为（防火墙、网口分配、主机名等）

编辑 `files/etc/uci-defaults/99-custom.sh`。这个脚本会在路由器**第一次**开机时执行一次，常见改动点：
- 关掉 WAN 入站放行（项目默认开着是为了让虚拟机用户首次能访问 WebUI，调试好之后建议关掉）；
- 给特殊开发板加 WAN/LAN 网口映射（看脚本里 `case "$board_name" in` 那段）；
- 改默认 DNS、加自定义 hosts 等。

### 想改默认勾选的插件列表

编辑对应平台的 `build<NN>.sh`（如 `x86-64/build25.sh`），里面有一段 `PACKAGES="$PACKAGES luci-..."` 的拼接，是**默认必装**的清单。

### 旁路由用法

**重要误区**：很多新手以为改 `custom_router_ip` 就能配旁路由——错。旁路由必须用单网口模式（DHCP），上级路由器分什么 IP 就用什么，进 LuCI 后台再手动配静态 IP 和指向主路由的网关。详见 README 里"旁路由的用户必读"一节。

---

## 四、目录速查

```
ImmortalWrt-ImageBuilder/
├── .github/workflows/       ← 所有"在线工厂"的入口，一个 yml 一种设备/版本
├── x86-64/                  ← x86 软路由的构建脚本和 .config
├── rockchip/                ← RK 系列开发板
├── sunxi-cortexa53/         ← 全志 H 系列
├── mediatek-filogic/        ← 联发科 Filogic
├── n1/                      ← 斐讯 N1
├── armsr-armv8/             ← 通用 ARM64
├── raspberrypi/             ← 树莓派（按版本分子目录）
├── glinet/                  ← GL.iNet 路由器特定的首启脚本
├── shell/                   ← 跨平台共享脚本
│   ├── custom-packages.sh        # opkg 时代第三方插件清单（你最常编辑这里）
│   ├── apk-custom-packages.sh    # apk 时代（25.x）第三方插件清单
│   ├── prepare-packages.sh       # 解包 .run 文件的辅助脚本
│   └── apk-prepare-packages.sh   # apk 版同上
├── files/etc/uci-defaults/
│   └── 99-custom.sh         ← 路由器首次开机执行的脚本（你第二常编辑这里）
├── model/                   ← 各芯片支持的型号清单（纯参考文档）
├── SUPPORT.md               ← 全部支持机型清单
├── PACKAGES.md              ← 可集成插件清单
└── README.md                ← 原作者说明（含视频教程链接）
```

---

## 五、常见问题

**Q：为什么 fork 后 Actions 没有运行权限？**
A：第一次进 Actions 标签要手动点 "I understand my workflows, go ahead and enable them"。

**Q：构建失败红叉怎么办？**
A：进对应 run 看日志，最常见原因是改 `custom-packages.sh` 时拼错了包名，或硬路由空间不够。

**Q：能不能本地编译？**
A：理论上可以——拉 ImmortalWrt 官方 imagebuilder docker 镜像，挂载本仓库后跑对应的 `build<NN>.sh` 就行（工作流里就是这么干的）。但本项目本身没准备本地构建的便利脚本，**推荐直接用 GitHub Actions**。

**Q：构建出的固件刷上去 WAN 口防火墙怎么是开的？**
A：故意的——为了让虚拟机用户首次能在 WAN 一侧访问 WebUI 完成初始化。**调试完毕请自己去"网络 → 防火墙 → WAN → 入站"改成"拒绝"**。

**Q：跟原版 ImmortalWrt 官方固件什么关系？**
A：没有官方背书。这是个人维护的第三方定制，问题别去 ImmortalWrt 官方群反馈，去本仓库 Discussions。

---

## 六、更深入的资料

- 视频教程（B 站）：README 顶部有原作者的链接
- 集成第三方插件方法：https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209
- 全部支持机型：见 `SUPPORT.md`
- 可选插件清单：见 `PACKAGES.md`
- ISO 安装器原理：https://github.com/wukongdaily/img-installer
- 原项目 Wiki：https://github.com/wukongdaily/AutoBuildImmortalWrt/wiki
