[![Github](https://img.shields.io/badge/Release文件可在国内加速站下载-FC7C0D?logo=github&logoColor=fff&labelColor=000&style=for-the-badge)](https://wkdaily.cpolar.top/archives/1) 
#### 固件地址 `192.168.100.1`
#### 用户名 `root` 密码：无
#### 默认软件包大小 1GB 


# ============= imm仓库内的插件==============
# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
PACKAGES="$PACKAGES curl"
# PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-theme-argon"
# PACKAGES="$PACKAGES luci-app-argon-config"
# PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"

#25.12
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
# PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES xray-core hysteria luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
# PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
PACKAGES="$PACKAGES snmpd"

# 文件管理器
# PACKAGES="$PACKAGES luci-i18n-filemanager-zh-cn"
PACKAGES="$PACKAGES -luci-app-fstab -luci-i18n-fstab-zh-cn -block-mount"
# ======== shell/apk-custom-packages.sh =======
# 合并imm仓库以外的第三方插件 暂时注释
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"
