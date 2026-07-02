# Repository Guidelines

## 项目结构与模块组织

本仓库用于通过 GitHub Actions 和 ImmortalWrt ImageBuilder 自动生成固件。`.github/workflows/` 保存各平台构建流程；`x86-64/`、`rockchip/`、`mediatek-filogic/`、`sunxi-cortexa53/`、`armsr-armv8/`、`n1/`、`raspberrypi/` 等目录保存目标平台的 `.config` 与 `build*.sh`；`shell/` 放置通用包处理脚本；`files/etc/uci-defaults/99-custom.sh` 是刷入固件后的首次启动配置；`arch/`、`model/` 保存架构和型号辅助配置。文档集中在 `README.md`、`PACKAGES.md`、`SUPPORT.md`。

## 构建、测试与开发命令

- `bash -n x86-64/build25.sh`：检查目标构建脚本语法。
- `sh -n files/etc/uci-defaults/99-custom.sh`：检查 OpenWrt 首启脚本语法。
- `sh shell/prepare-packages.sh`：整理 `.run` 解包得到的 `.ipk` 到 `packages/`，需在有 `extra-packages/` 时运行。
- GitHub Actions `workflow_dispatch`：主要构建入口。修改某平台后，优先手动触发对应 workflow，例如 `Build 25.12.x x86-64` 或 `Build 25.12.x Rockchip`。

## 编码风格与命名约定

Shell 脚本保持 POSIX `sh` 或 Bash shebang 与实际语法一致；变量使用大写下划线，如 `CUSTOM_PACKAGES`、`ROOTFS_PARTSIZE`。缩进使用 2 或 4 个空格，但同一文件内保持一致。YAML 使用 2 空格缩进，workflow 文件名采用 `build-平台-版本.yml` 形式。新增平台目录应使用小写加连字符命名，并提供对应 `build.sh` 或 `build25.sh` 与配置文件。

## 测试指南

本仓库没有独立单元测试框架。提交前至少对改动过的脚本运行 `bash -n` 或 `sh -n`；修改 workflow 时用 GitHub Actions 页面或 `actionlint` 验证 YAML。涉及包列表、Docker、PPPoE、默认 IP 或防火墙配置的改动，必须触发一次受影响平台的构建，并确认 release artifact 生成成功。

## 提交与 Pull Request 规范

历史提交同时使用简短祈使句和 `feat:`、`fix:` 前缀。建议继续使用清晰短句，例如 `fix: update ssrp dependencies`、`feat: add 25.12 rockchip profile`。PR 需说明受影响平台、ImmortalWrt/LuCI 版本、是否改动默认网络行为，并附上相关 workflow 运行链接。若新增或移除软件包，请说明原因和潜在体积影响。

## 安全与配置提示

不要提交本地生成的固件、私有账号密码或 PPPoE 凭据。修改 `files/etc/uci-defaults/99-custom.sh` 时，注意单网口设备默认 DHCP、多网口设备默认静态 LAN IP 的差异，避免让用户刷机后失联。
