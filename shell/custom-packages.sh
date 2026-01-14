#!/bin/bash
# ============= imm仓库外的第三方插件==============
# ============= 若启用 则打开注释 ================
# ============= 但此文件也可以处理仓库内的软件去留 本质上是做了一个PACKAGES字符串的拼接 ================

# 各位注意 如果你构建的固件是硬路由 此文件的注释要酌情考虑是否打开 因为硬路由的闪存空间有限 若构建出来过大或者构建失败 记得调整本文件的注释
# 考虑到istore商店的集成与否 属于高频操作 故 目前已将集成store的操作放置在 工作流的UI 选项 用户自行勾选 则集成  不勾选则不集成 以减少修改此文件的次数

# 首页和网络向导
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-quickstart-zh-cn"
# 高级卸载 by YT Vedio Talk
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-uninstall"
# 极光主题 by github eamonxg
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-theme-aurora"
# 去广告adghome
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adguardhome"
# 代理相关
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-passwall-zh-cn"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ssr-plus"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-passwall2"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-nikki-zh-cn"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nekobox"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES momo luci-app-momo luci-i18n-momo-zh-cn"
# 同样是代理相关 但以下2个属于imm仓库内的软件 一般在build24.sh中已经集成 你也可以在此处调整它的去留 若去除组件则使用减号- 若添加则 不使用减号 或者 不处理
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-app-openclash"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-i18n-homeproxy-zh-cn"
# VPN
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-tailscale luci-i18n-tailscale-zh-cn"
# 分区扩容 by sirpdboy 
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-partexp luci-i18n-partexp-zh-cn"
# 酷猫主题 by sirpdboy 
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-theme-kucat"
# 进阶设置 by sirpdboy 
# 当luci-app-advancedplus插件开启时 需排除冲突项 luci-app-argon-config和luci-i18n-argon-config-zh-cn 减号代表排除
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-advancedplus luci-i18n-advancedplus-zh-cn -luci-app-argon-config -luci-i18n-argon-config-zh-cn"
# 网络测速 by sirpdboy 
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netspeedtest luci-i18n-netspeedtest-zh-cn"
# MosDNS
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mosdns luci-i18n-mosdns-zh-cn"
# Turbo ACC 网络加速
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-turboacc"
# 应用过滤 openappfilter.com
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-appfilter luci-i18n-appfilter-zh-cn"
# 设置向导 by sirpdboy
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netwizard luci-i18n-netwizard-zh-cn"
# Lucky大吉 
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-lucky lucky"
# 集客AC
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-gecoosac gecoosac"
# 任务设置
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-taskplan luci-i18n-taskplan-zh-cn"
# Easytier
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES easytier luci-app-easytier"
# 统一文件共享
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES webdav2 luci-app-unishare"
# IPSec VPN 服务器
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-ipsec-vpnd-zh-cn"
# Bandix流量监控 by timsaya
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-bandix luci-i18n-bandix-zh-cn"
# IPTV 流媒体转发服务器 - rtp2httpd by stackia
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-rtp2httpd luci-i18n-rtp2httpd-zh-cn"

