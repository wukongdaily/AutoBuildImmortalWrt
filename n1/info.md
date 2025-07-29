## ImmortalWrt for 斐讯N1
#### luci版本 24.10.2 固件不是传统ext4和squashfs格式 而是btrfs格式 支持快照
#### 后台地址 `没有没有没有,需查询` 详见下文
#### 用户名 `root` 密码：password
#### 是否带docker: 根据用户选择
#### 默认软件包大小 1GB
#### 内核版本:根据用户选择
#### 晶晨宝盒：✅ 自带 用于写入emmc 写入的时候务必关闭docker 和docker自启动 （这一步等以后稳定再考虑写入 非必要不写入）
#### rootfs.tar.gz 构建采用ImmortalWrt的ImageBuilder
#### 打包img 采用`onhub/amlogic-s9xxx-openwrt` 或 `flippy-openwrt-actions`
#### 默认底包位置：https://github.com/wukongdaily/AutoBuildImmortalWrt/releases/tag/rootfs


### 斐讯N1为单网口设备 网线接上路由器 启动后默认是自动获取ip的模式<br> 请在上级路由器的dhcp列表中查询具体的局域网ip
### 若后续想设置其他ip或者旁路 请在web页面自行设置即可 <br> 总之 这个逻辑就是默认让它有网 和 普通电脑、NAS 无异
### 一定要阅读清楚 再刷机 推荐使用U盘做测试（0风险） 不建议一开始就写入EMMC
## 各位尽量不要直接使用项目中的release 要自己fork项目后自行构建  <br> 本项目中的release仅用于作者测试 且会定期删除
##### 若release中下载吃力 可在国内加速站下载 
[![Github](https://img.shields.io/badge/Release文件可在国内加速站下载-FC7C0D?logo=github&logoColor=fff&labelColor=000&style=for-the-badge)](https://wkdaily.cpolar.top/archives/1) 
