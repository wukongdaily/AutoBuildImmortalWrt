# AutoBuildImmortalWrt for NanoPi R4S

[![LICENSE](https://img.shields.io/github/license/wukongdaily/AutoBuildImmortalWrt.svg?label=LICENSE&logo=github)](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&label=Stars)
![GitHub Forks](https://img.shields.io/github/forks/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&label=Forks)
[![Release](https://img.shields.io/badge/Release-AutoBuildImmortalWrt-green)](https://github.com/wukongdaily/AutoBuildImmortalWrt/releases)

## 💡 项目简介

本仓库用于为 **FriendlyElec NanoPi R4S（rockchip/armv8 平台）** 自动构建 **ImmortalWrt 固件**，当前主要面向 ImmortalWrt 24.10.4 与 LuCI 24.10 分支的使用场景。[conversation_history:1]  
通过 GitHub Actions，一键完成固件编译、插件集成与（可选）ISO 安装器封装。

## 📦 设备与系统信息

- 设备型号：FriendlyElec NanoPi R4S（双网口软路由）  
- 架构：ARMv8 六核 SoC（rockchip/armv8 目标平台）  
- 固件版本：ImmortalWrt 24.10.4 / LuCI openwrt-24.10  
- 内核版本：6.6.110  

以上信息对应当前实际运行环境，方便后续固件构建时保持一致的平台与版本选择。[conversation_history:1]

## ✨ 主要特性

- 支持为 NanoPi R4S 定制构建 ImmortalWrt 固件  
- 固件大小可自定义（默认约 1G，可根据需要调整）  
- 可选预装 Docker 与应用商店，适合做软路由 + 轻量服务  
- 支持集成第三方插件（通过自定义插件仓库）  
- 可选不同版本的 LuCI 界面，默认使用最新版 24.10.x 分支  
- 支持为虚拟机/物理机生成 ISO 安装器，方便快速安装或迁移

## 🚀 基本使用步骤

1. Fork 本仓库到自己的 GitHub 账号  
2. 在自己的仓库中打开 **Actions**  
3. 找到适用于 NanoPi R4S 的工作流（rockchip/armv8）  
4. 按需求修改配置（固件大小、插件、Docker、Luci 版本等）  
5. 点击 **Run workflow**，等待云端完成构建  
6. 从构建产物中下载对应的固件或 ISO 安装器，刷入到 NanoPi R4S 使用

如需更详细的操作说明，可参考原项目 Wiki 或视频教程。

## 🌐 网络与使用说明（R4S）

- R4S 属于多网口设备：  
  - 默认 WAN 口：DHCP 自动获取上级 IP  
  - 默认 LAN 口：`192.168.100.1`，提供 DHCP 给下级设备  
- 如需避免与光猫或其它路由冲突，可在构建前或系统内修改默认管理 IP（例如改为 `192.168.80.1` 等）。  
- 若选择 PPPoE 拨号，建议在使用前重启光猫，以避免旧会话占用。

## 🔒 防火墙与安全

为了便于首次调试，本固件默认 WAN 入站规则是开启的。  
建议调试完成后在 LuCI 中关闭 WAN 入站：

> 网络 → 防火墙 → 区域：WAN → 入站规则改为 “拒绝” → 保存并应用

这样可以降低暴露在公网时的安全风险。

## 📹 教程与相关项目

- 固件构建与插件集成视频教程  
- ISO 安装器原理与用法：参见 img-installer 项目  
- 插件列表与扩展说明：参见第三方插件仓库与讨论区

（可根据自己实际常用链接补充具体地址）

## ❤️ 鸣谢与引用

本项目构建流程与部分配置参考并感谢以下项目与作者（仅示例，可按需增删）：

- ImmortalWrt 项目及相关维护者  
- 各类 NanoPi R4S / rockchip 平台 OpenWrt/ImmortalWrt 构建相关仓库  
- 主题、插件与工具作者

## ☕ 支持与反馈

如果本项目对你有帮助，欢迎 Star、本地备份或分享给其他 NanoPi R4S 用户。  
如有问题或建议，可通过 Issues / Discussions 提交反馈。
