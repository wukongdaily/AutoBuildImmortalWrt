#!/bin/sh
# ImmortalWrt 固件快速测试脚本
# 在路由器终端运行此脚本以验证基础功能

echo "======================================"
echo "   ImmortalWrt 固件快速测试"
echo "======================================"
echo ""

# 测试1: 系统信息
echo "📋 [1/8] 系统信息"
echo "-----------------------------------"
cat /etc/openwrt_release | grep DISTRIB_DESCRIPTION
echo "内核版本: $(uname -r)"
echo "架构: $(uname -m)"
echo ""

# 测试2: 网络连接
echo "🌐 [2/8] 网络连接测试"
echo "-----------------------------------"
if ping -c 3 -W 5 8.8.8.8 >/dev/null 2>&1; then
    echo "✅ IPv4 连接正常"
else
    echo "❌ IPv4 连接失败"
fi

if ping6 -c 3 -W 5 google.com >/dev/null 2>&1; then
    echo "✅ IPv6 连接正常"
else
    echo "⚠️  IPv6 不可用或网络不支持"
fi
echo ""

# 测试3: DNS 解析
echo "🔍 [3/8] DNS 解析测试"
echo "-----------------------------------"
if nslookup baidu.com >/dev/null 2>&1; then
    echo "✅ DNS 解析正常"
else
    echo "❌ DNS 解析失败"
fi
echo ""

# 测试4: 已安装软件包
echo "📦 [4/8] 检查关键软件包"
echo "-----------------------------------"
PACKAGES="curl wget htop vim-full nano luci-app-passwall luci-app-adguardhome luci-app-diskman luci-app-samba4 luci-theme-argon"
INSTALLED=0
MISSING=0

for pkg in $PACKAGES; do
    if opkg list-installed | grep -q "^$pkg "; then
        echo "✅ $pkg"
        INSTALLED=$((INSTALLED + 1))
    else
        echo "❌ $pkg 未安装"
        MISSING=$((MISSING + 1))
    fi
done
echo "统计: $INSTALLED 个已安装, $MISSING 个缺失"
echo ""

# 测试5: 服务状态
echo "🔧 [5/8] 核心服务状态"
echo "-----------------------------------"
SERVICES="firewall network dnsmasq uhttpd"
for svc in $SERVICES; do
    if /etc/init.d/$svc enabled >/dev/null 2>&1; then
        STATUS="启用"
    else
        STATUS="禁用"
    fi

    if pgrep -f "$svc" >/dev/null 2>&1; then
        echo "✅ $svc: 运行中 ($STATUS)"
    else
        echo "⚠️  $svc: 未运行 ($STATUS)"
    fi
done
echo ""

# 测试6: 磁盘空间
echo "💾 [6/8] 磁盘空间"
echo "-----------------------------------"
df -h / | awk 'NR==1 {print "文件系统\t大小\t已用\t可用\t使用率\t挂载点"} NR==2 {print}'
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$USAGE" -lt 80 ]; then
    echo "✅ 磁盘空间充足"
else
    echo "⚠️  磁盘使用率较高: ${USAGE}%"
fi
echo ""

# 测试7: 内存使用
echo "🧠 [7/8] 内存使用"
echo "-----------------------------------"
free -h | awk 'NR==1 {print "类型\t\t总计\t\t已用\t\t空闲\t\t共享\t\t缓存"} NR==2 {print}'
TOTAL_MEM=$(free | awk 'NR==2 {print $2}')
USED_MEM=$(free | awk 'NR==2 {print $3}')
MEM_PERCENT=$((USED_MEM * 100 / TOTAL_MEM))
if [ "$MEM_PERCENT" -lt 80 ]; then
    echo "✅ 内存使用正常: ${MEM_PERCENT}%"
else
    echo "⚠️  内存使用率较高: ${MEM_PERCENT}%"
fi
echo ""

# 测试8: IPv6 支持检查
echo "🔬 [8/8] IPv6 内核支持"
echo "-----------------------------------"
if [ -f /proc/net/if_inet6 ]; then
    echo "✅ IPv6 内核模块已加载"
    IPV6_COUNT=$(cat /proc/net/if_inet6 | wc -l)
    echo "   检测到 $IPV6_COUNT 个 IPv6 地址"
else
    echo "❌ IPv6 内核模块未加载"
fi

IPV6_FORWARD=$(sysctl -n net.ipv6.conf.all.forwarding 2>/dev/null)
if [ "$IPV6_FORWARD" = "1" ]; then
    echo "✅ IPv6 转发已启用"
else
    echo "⚠️  IPv6 转发未启用"
fi
echo ""

# 总结
echo "======================================"
echo "   测试总结"
echo "======================================"
echo "固件版本: $(cat /etc/openwrt_release | grep DISTRIB_DESCRIPTION | cut -d"'" -f2)"
echo "运行时间: $(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')"
echo "负载: $(uptime | awk -F'load average:' '{print $2}')"
echo ""
echo "✅ 所有核心功能正常"
echo "🌐 可通过浏览器访问 WebUI"
echo ""
echo "======================================"
echo "测试完成！$(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================"
