# YuHan x86-64 专属固件

本仓库用于构建 Han 的专属 x86-64 固件，特点：

- 极简插件：Passwall + MosDNS + Docker
- 默认 LAN IP：192.168.8.88
- DHCP 关闭（旁路由模式）
- Argon 主题
- 双启动（Legacy + EFI）
- 自动化构建（GitHub Actions）
- 自动化默认配置（uci-defaults）

## 构建方式

进入 Actions → Build x86-64 24.10 → Run workflow

## 目录结构

- x86-64/ → 固件配置与构建脚本  
- files/ → 默认系统配置  
- .github/workflows → 自动构建脚本  
