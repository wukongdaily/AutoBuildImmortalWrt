## 🤔 这是什么？
基于 CI 的 ImageBuilder 工作流，用于自动化构建 ImmortalWrt 固件。
> 1、支持自定义固件大小 默认1GB 不建议设置过大 推荐1G-2G 更大需求可通过自定义插件里的扩容插件自行扩容<br>
> 2、支持可选预安装docker（可选）支持在UI上勾选是否集成商店 （24.10.6以下）<br>
> 3、支持按需增加[第三方软件](https://github.com/wukongdaily/store/blob/master/README.md)  如何集成 https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/209 <br>
> 4、点击这里查看👉🏻[全部支持的机型列表](https://github.com/wukongdaily/AutoBuildImmortalWrt/blob/master/SUPPORT.md) 👈🏻<br>
> 5、在UI上 新增luci版本的可选项，默认最新版25.12.x https://github.com/wukongdaily/AutoBuildImmortalWrt/discussions/426<br>
> 6、支持设置管理地址的ip 比如192.168.100.1 这里强调 这项功能仅针对多网口机型 单网口的逻辑还是自动获取ip模式（dhcp）无固定ip<br>
> 7、对于[插件追新的用户 建议前往run项目 下载run后 ](https://github.com/wukongdaily/RunFilesBuilder/discussions/41)用命令sh xx.run 覆盖安装 <br>
> 8、支持24.10.x 、25.12.x 等版本 （包括x86-64-ISO、x86-64、rockchip、全志sunxi、无线路由器）

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
网络——防火墙—— wan 的入站 选择拒绝 然后保存并应用即可。
