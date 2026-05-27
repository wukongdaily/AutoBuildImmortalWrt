[![Github](https://img.shields.io/badge/Release文件可在国内加速站下载-FC7C0D?logo=github&logoColor=fff&labelColor=000&style=for-the-badge)](https://wkdaily.cpolar.top/archives/1) 
#### 此固件为ARM64虚拟机专用
#### 格式为qcow2 该格式可在虚拟机里自由扩展大小 无需添加另一块虚拟硬盘
#### 固件地址 `192.168.100.1`
#### 用户名 `root` 密码：无
#### 默认软件包大小 2GB

##### 该固件导入单网口虚拟机的时候 默认采用DHCP模式 在虚拟机终端输入`ip a` 查看ip 后访问web
##### 该固件导入多网口虚拟机的时候 默认第一个网口采用DHCP模式 视为wan 其他网口自动br-lan 
##### 若release中下载吃力 可在国内加速站下载 https://wkdaily.cpolar.top/archives/1

- 你可以理解为这是一种ARM64 通用型OpenWrt ,产出格式为qcow2,适合所有ARM64平台的虚拟机
- 举例来说 目前有哪些arm64虚拟机？
- 比如斐讯N1刷了armbian系统,armbian系统里安装了PVE虚拟机 可用
- 比如新款Apple Silicon芯片的苹果电脑里的虚拟机UTM 可用
- 比如友善NanoPi R3S、R5S 官方推出的预装了PVE的debian系统 可用
- 比如瑞莎E20C刷了Armbian系统，自己安装了QEMU+原生的KVM虚拟机 可用