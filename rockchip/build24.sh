#!/bin/bash
# 优化版固件构建脚本
set -euo pipefail  # 遇到错误立即退出，未定义变量报错，管道失败退出

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "/tmp/build.log"
}

# 验证必要环境变量
required_vars=(PROFILE ROOTFS_PARTSIZE)
for var in "${required_vars[@]}"; do
    if [[ -z "${!var:-}" ]]; then
        log "错误：缺少必要环境变量 $var"
        exit 1
    fi
done

log "开始构建 - 型号: $PROFILE, 分区大小: $ROOTFS_PARTSIZE"

# 加载自定义包配置
source shell/custom-packages.sh 2>/dev/null || log "警告：未找到 custom-packages.sh"

log "第三方软件包: '${CUSTOM_PACKAGES:-无}'"

# 创建PPPoE配置文件
PPPOE_DIR="/home/build/immortalwrt/files/etc/config"
mkdir -p "$PPPOE_DIR"
cat > "$PPPOE_DIR/pppoe-settings" << EOF
enable_pppoe=${ENABLE_PPPOE:-no}
pppoe_account=${PPPOE_ACCOUNT:-}
pppoe_password=${PPPOE_PASSWORD:-}
EOF
log "PPPoE配置已创建"

# 处理自定义软件包
if [[ -n "${CUSTOM_PACKAGES:-}" ]]; then
    log "🔄 同步第三方软件仓库..."
    
    # 安全克隆仓库
    rm -rf /tmp/store-run-repo
    if ! git clone --depth=1 https://github.com/wukongdaily/store.git /tmp/store-run-repo; then
        log "❌ 克隆仓库失败，跳过自定义包"
        CUSTOM_PACKAGES=""
    else
        # 复制run文件
        EXTRA_PKG_DIR="/home/build/immortalwrt/extra-packages"
        mkdir -p "$EXTRA_PKG_DIR"
        if [[ -d /tmp/store-run-repo/run/arm64 ]]; then
            cp -rf /tmp/store-run-repo/run/arm64/"*".{run,ipk} "$EXTRA_PKG_DIR/" 2>/dev/null || true
            log "✅ 已复制 $(ls "$EXTRA_PKG_DIR"/*.run 2>/dev/null | wc -l) 个run文件"
        fi
        
        # 准备ipk包
        if [[ -f shell/prepare-packages.sh ]]; then
            sh shell/prepare-packages.sh
        fi
    fi
fi

# 构建包列表（使用数组避免空格问题）
declare -a PACKAGES=(
    "curl" "openssh-sftp-server"
    "luci-i18n-package-manager-zh-cn" "luci-i18n-firewall-zh-cn"
    "luci-theme-argon" "luci-app-argon-config" "luci-i18n-argon-config-zh-cn"
    "luci-app-diskman" "luci-i18n-diskman-zh-cn"
    "luci-app-hd-idle" "luci-i18n-hd-idle-zh-cn"
    "luci-app-samba4" "luci-i18n-samba4-zh-cn"
    "luci-app-aria2" "luci-i18n-aria2-zh-cn"
    "luci-i18n-openlist-zh-cn" "luci-i18n-passwall-zh-cn"
)

# Docker支持
if [[ "${INCLUDE_DOCKER:-no}" == "yes" ]]; then
    PACKAGES+=("luci-i18n-dockerman-zh-cn")
fi

# 添加自定义包
[[ -n "${CUSTOM_PACKAGES:-}" ]] && PACKAGES+=($CUSTOM_PACKAGES)

# 转字符串并构建
PKG_LIST=$(IFS=' '; echo "${PACKAGES[*]}")
log "📦 构建包列表: $PKG_LIST"

# 执行构建
log "🚀 开始构建固件..."
if ! make image PROFILE="$PROFILE" \
    PACKAGES="$PKG_LIST" \
    FILES="/home/build/immortalwrt/files" \
    ROOTFS_PARTSIZE="$ROOTFS_PARTSIZE"; then
    log "❌ 构建失败！"
    exit 1
fi

log "✅ 固件构建完成！"
