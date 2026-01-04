# AutoBuildImmortalWrt for NanoPi R4S

[![LICENSE](https://img.shields.io/github/license/wukongdaily/AutoBuildImmortalWrt.svg?label=LICENSE&logo=github)](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/LICENSE)
[![Release](https://img.shields.io/badge/Release-AutoBuildImmortalWrt-green)](https://github.com/wukongdaily/AutoBuildImmortalWrt/releases)

## 简介

为 **FriendlyElec NanoPi R4S（rockchip/armv8）** 自动构建 **ImmortalWrt 24.10.4 固件**，支持自定义固件大小、预装 Docker、第三方插件以及可选 ISO 安装器。[conversation_history:1]

## 当前环境

- 设备：NanoPi R4S  
- 架构：ARMv8 / rockchip/armv8  
- 固件：ImmortalWrt 24.10.4 + LuCI 24.10 分支  
- 内核：6.6.110[conversation_history:1]

## 使用方式

1. Fork 本仓库到自己的 GitHub  
2. 在 **Actions** 中选择适用于 NanoPi R4S 的工作流  
3. 按需编辑配置（固件大小、插件、Docker、Luci 版本等）  
4. 运行工作流并下载生成的固件或 ISO，刷入 NanoPi R4S 即可

## 网络默认说明（R4S）

- 多网口设备：  
  - WAN：默认 DHCP  
  - LAN：默认 `192.168.100.1`，提供 DHCP  
- 如与现有网络冲突，可在配置中修改默认管理 IP。[conversation_history:1]

## 防火墙建议

首次调试完成后，建议在 LuCI 中将 WAN 入站规则改为「拒绝」，提升公网暴露时的安全性。
