# 临时的紧急通知 [点这里看](https://github.com/wukongdaily/AutoBuildImmortalWrt/issues/563)
# AutoBuildImmortalWrt
[![GitHub](https://img.shields.io/github/license/wukongdaily/AutoBuildImmortalWrt.svg?label=LICENSE&logo=github&logoColor=%20)](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&logo=appveyor&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/wukongdaily/AutoBuildImmortalWrt.svg?style=flat&logo=appveyor&label=Forks&logo=github) [![Github](https://img.shields.io/badge/RELEASE:AutoBuildImmortalWrt-123456?logo=github&logoColor=fff&labelColor=green&style=flat)](https://github.com/wukongdaily/AutoBuildImmortalWrt/releases) [![Bilibili](https://img.shields.io/badge/Bilibili-123456?logo=bilibili&logoColor=fff&labelColor=fb7299)](https://www.bilibili.com/video/BV1EG6VYCER3) [![操作步骤](https://img.shields.io/badge/YouTube-123456?logo=youtube&labelColor=ff0000)](https://youtu.be/xIVtUwZR6U0)

## 🤔 这是什么？
它是一个工作流。可快速构建 带docker且支持自定义固件大小的 immortalWrt
> 1、支持自定义固件大小 默认1GB 不建议设置过大 推荐1G-2G 更大需求可通过自定义插件里的扩容插件自行扩容<br>
> 2、支持可选预安装docker（可选）支持在UI上勾选是否集成商店<br>
> 3、支持按需增加[第三方软件](https://github.com/wukongdaily/store/blob/master/README.md)  如何集成 https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209 <br>
> 4、点击这里查看👉🏻[全部支持的机型列表](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/SUPPORT.md) 👈🏻<br>
> 5、在UI上 新增luci版本的可选项，默认最新版24.10.4 https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/426<br>
> 6、支持设置管理地址的ip 比如192.168.100.1 这里强调 这项功能仅针对多网口机型 单网口的逻辑还是自动获取ip模式（dhcp）无固定ip<br>
> 7、对于[插件追新的用户 建议前往run项目 下载run后 ](https://github.com/wukongdaily/RunFilesBuilder/discussions/41)用命令sh xx.run 覆盖安装 <br>

## [基本用法步骤](https://github.com/wukongdaily/AutoBuildImmortalWrt/wiki) 👈🏻
1、fork本项目<br>
2、在fork后的项目中 点击【action】 找到需要的工作流后 run-workflow<br>

## 虚拟机建议用哪条工作流？下图↓
<img width="30%" height="30%" alt="image" src="https://github.com/user-attachments/assets/743027e0-584a-4842-bfb3-0dff22de9101" /> <br>
虚拟机用户建议直接构建ISO镜像 此过程分2个阶段 阶段一构建固件imm 阶段二将其封装iso格式的安装器 总计耗时大约7-8分钟  <br>
ISO在虚拟机引导后 跑码结束后，在命令行输入 `ddd` 按提示 完成虚拟磁盘的写入（安装immortalwrt到虚拟磁盘）<br>
这样做也比较灵活 避免了格式转换和解压 同时还可以指定安装某个磁盘 而安装后的磁盘剩余空间也能加以利用。<br>
详细的解说 可以参考我的另一个项目 [img-installer](https://github.com/wukongdaily/armbian-installer) 

## 虚拟机用户使用的教学⬇️ ISO 
[![操作步骤](https://img.shields.io/badge/YouTube-123456?logo=youtube&labelColor=ff0000)](https://www.youtube.com/watch?v=ftSE3wSJi64) [![Bilibili](https://img.shields.io/badge/Bilibili-123456?logo=bilibili&logoColor=fff&labelColor=fb7299)](https://www.bilibili.com/video/BV1enxMzwEUe/)

## 物理机如何使用ISO格式的安装器(本项目独有)
- Windows 建议将ISO拷贝到制作好的[Ventoy](https://www.ventoy.net/cn/index.html)<br>
  <img width="303" height="90" alt="image" src="https://github.com/user-attachments/assets/34d73e24-3100-4c0d-a904-5f114d867793" />

- macOS 使用[balenaEtcher](https://etcher.balena.io/) 将ISO 刻录到U盘即可<br>
  <img width="285" height="188" alt="image" src="https://github.com/user-attachments/assets/cd09be82-2670-404c-8878-c2782b3c8374" />

- 将制作好的U盘提前插在软路由 然后启动后 按Del 或者F12、F11、F7等 使U盘成为第一启动盘

  <img width="50%" alt="image" src="https://github.com/user-attachments/assets/a1ba38d9-305c-41dd-8441-9e61c3dcae1d" /> <br>
- 启动后在命令行输入 ddd 按提示 完成硬盘的写入 硬盘剩余空间你还可以自动分配<br>
- ISO安装器原理 点这里查看 https://github.com/wukongdaily/img-installer
- 这是一个值得推广的方法 真心希望你能吸收、学会 费了很大心思的。没错、从今往后 [任何OpenWrt都有安装器了](https://github.com/wukongdaily/img-installer)

## 如何查询imm仓库内有哪些插件
https://mirrors.sjtug.sjtu.edu.cn/immortalwrt/releases/24.10.4/packages/x86_64/luci/
## 如何查询imm仓库外目前可以集成哪些插件
https://github.com/wukongdaily/store
> 具体方法 https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209
## 【视频教程】如何集成第三方插件？
https://www.youtube.com/watch?v=KN6AJYV1hBI <br>
https://www.youtube.com/watch?v=7i6BQeitUtE

## 旁路由的用户必读
近期不少用户修改配置文件中的默认ip地址，误认为这个工作流可以直接设置旁路ip。这是巨大的误解，这样设置就乱套了。<br>
旁路的逻辑应该是单网口模式。根据下面的固件属性可知。单网口默认采取`dhcp模式`，用户应当自行在上一级路由器查看给imm路由器分配的ip地址。
然后通过该ip来访问imm后台页面，在imm后台页面中，根据自己主路由的网段 自行配置旁路的ip地址。

## 正常路由模式必读
所谓正常的路由模式 就是指多网口用户，多网口的意思就是2个或者2个以上网口的情况。<br>
一般wan用于拨号或者自动获取ip <br>
而其他lan一般是给其他设备分配dhcp<br>
这种情况下 你可以修改路由器的默认ip  `192.168.100.1` 比如你可以修改为`192.168.80.1 ` 诸如此类。<br>
没错，修改此ip 无非就是为了避免跟光猫或者跟家庭中的其他路由器网段冲突。大多数用户，无需更改。

## 该固件默认属性？(必读)
- 该固件刷入【单网口设备】默认采用DHCP模式,自动获得ip。类似NAS的做法
- 该固件刷入【多网口设备】默认WAN口采用DHCP模式，LAN 口ip为  `192.168.100.1` <br>其中eth0为WAN 其余网口均为LAN
- 若用户在工作流中勾选了拨号信息 则WAN口模式为pppoe拨号模式。
- 建议拨号用户使用之前重启一次光猫。
- 综合上述特点，【单网口设备】应该先接路由器，先在上级路由器查看一下它的ip 再访问。
- 上述特点 你都可以通过 `99-custom.sh` 配置和调整

## 特别说明
本项目构建的固件 为了易用性 wan口防火墙规则入站 是开启的，待首次调试完毕后，建议自行关闭。操作方法如下
网络——防火墙—— wan 的入站 选择拒绝 然后保存并应用即可。更多讨论[ 请参考这个话题](https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/341)
<img width="3860" height="870" alt="image" src="https://github.com/user-attachments/assets/d826bccd-f0df-4d4a-877d-b711b81fcf1a" />
同时此项设置的相关代码详见 `files/etc/uci-defaults/99-custom.sh` 行首

## ❤️其它GitHub Action项目推荐🌟 （建议收藏）⬇️
- ### [一键生成run插件] 🆕
- https://github.com/wukongdaily/RunFilesBuilder<br>
- ### [一键生成docker离线镜像] 🆕
- https://github.com/wukongdaily/DockerTarBuilder<br>
- ### [OpenWrt/Armbian IMG安装器ISO] 🆕
- https://github.com/wukongdaily/img-installer


## ❤️如何构建docker版ImmortalWrt（建议收藏）⬇️
https://wkdaily.cpolar.cn/15
# 🌟鸣谢
### https://github.com/immortalwrt
### https://github.com/ophub/flippy-openwrt-actions
### https://github.com/ophub/amlogic-s9xxx-openwrt
### https://github.com/sirpdboy
### https://github.com/wukongdaily/ib-overlay
### 高级卸载插件出处 by VedioTalk https://xz.vumstar.com
### 新增极光主题 来自 https://github.com/eamonxg/luci-theme-aurora
### 新增Bandix流量监控 来自 https://github.com/timsaya/luci-app-bandix
### 新增rtp2httpd 来自https://github.com/stackia/rtp2httpd

## ❤️赞助作者 ⬇️⬇️

[![点击这里赞助我](https://img.shields.io/badge/点击这里赞助我-支持作者的项目-orange?logo=github)](https://wkdaily.cpolar.cn/01)




<details>
<summary><h2>🍭相关引用</h2></summary>

#### 🍭引用和项目参考的仓库
- https://github.com/wukongdaily/RunFilesBuilder
- https://github.com/wukongdaily/store
- https://github.com/xiaorouji/openwrt-passwall
- https://github.com/xiaorouji/openwrt-passwall2
- https://github.com/sirpdboy/luci-theme-kucat
- https://github.com/AdguardTeam/AdGuardHome
- https://github.com/kiddin9/kwrt-packages
