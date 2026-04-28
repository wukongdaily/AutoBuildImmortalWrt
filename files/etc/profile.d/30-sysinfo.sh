#!/bin/sh

# ===================== 颜色定义 =====================
GREEN=$(printf "\033[32m")
YELLOW=$(printf "\033[33m")
RED=$(printf "\033[91m")
RESET=$(printf "\033[0m")
MAGENTA=$(printf "\033[35m")

# ===================== 运行时间（基于 /proc/uptime） =====================
get_uptime() {
    if [ -r /proc/uptime ]; then
        uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
    else
        raw=$(uptime 2>/dev/null)
        days=0; hours=0; mins=0
        case "$raw" in
            *"day"*|*"days"*)
                days=$(echo "$raw" | sed -E 's/.* up ([0-9]+) days?.*/\1/')
                ;;
        esac
        if echo "$raw" | grep -qE '[0-9]+:[0-9]+'; then
            hm=$(echo "$raw" | sed -E 's/.* ([0-9]+:[0-9]+).*/\1/')
            hours=${hm%:*}
            mins=${hm#*:}
        elif echo "$raw" | grep -qE '[0-9]+ min'; then
            mins=$(echo "$raw" | sed -E 's/.* ([0-9]+) min.*/\1/')
        fi
        echo "${days}天 ${hours}小时 ${mins}分钟"
        return
    fi

    days=$((uptime_seconds / 86400))
    hours=$(( (uptime_seconds % 86400) / 3600 ))
    mins=$(( (uptime_seconds % 3600) / 60 ))
    echo "${days}天 ${hours}小时 ${mins}分钟"
}

uptime_str=$(get_uptime)

# ===================== 通用 IP 地址获取（不依赖接口名） =====================
# 获取 IPv4：优先选择私有地址（192.168.x.x, 10.x.x.x, 172.16-31.x.x）
# 如果没有私有地址，则取第一个非回环、非链路本地的 IPv4
get_lan_ipv4() {
    # 私有地址正则（A类:10.0.0.0/8, B类:172.16.0.0/12, C类:192.168.0.0/16）
    ipv4_private=$(ip -4 addr show 2>/dev/null | grep -oE 'inet (10\.[0-9]+\.[0-9]+\.[0-9]+|172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]+\.[0-9]+|192\.168\.[0-9]+\.[0-9]+)' | awk '{print $2}' | head -n1)
    if [ -n "$ipv4_private" ]; then
        echo "$ipv4_private"
        return
    fi
    # 没有私有地址则取第一个非回环、非169.254.*.*的地址
    ip -4 addr show 2>/dev/null | grep -v 'inet 127\.0\.0\.' | grep -v 'inet 169\.254\.' | grep -m1 inet | awk '{print $2}' | cut -d/ -f1
}

# 获取 IPv6：取第一个 scope global 的地址（排除链路本地和回环）
get_lan_ipv6() {
    ip -6 addr show scope global 2>/dev/null | awk '/inet6/ && !/::1/ {print $2}' | cut -d/ -f1 | head -n1
}

lan_ip4=$(get_lan_ipv4)
lan_ip6=$(get_lan_ipv6)

lan_ip4=${lan_ip4:-"无"}
lan_ip6=${lan_ip6:-"无"}

# ===================== 系统负载 =====================
core=$(grep -c processor /proc/cpuinfo 2>/dev/null || echo 1)
load=$(cat /proc/loadavg 2>/dev/null | awk '{print $1" "$2" "$3}')
load_val=$(echo "$load" | awk '{print $1}')
load_val=${load_val:-0}

color_load=$GREEN
if awk -v l="$load_val" -v c="$core" 'BEGIN{exit !(l > c)}'; then
    color_load=$RED
elif awk -v l="$load_val" -v c="$core" 'BEGIN{exit !(l > c*0.7)}'; then
    color_load=$YELLOW
fi

# ===================== 内存 =====================
mem_total=$(grep MemTotal /proc/meminfo 2>/dev/null | awk '{print int($2/1024)}')
mem_used=0
if grep -q MemAvailable /proc/meminfo 2>/dev/null; then
    mem_avail=$(grep MemAvailable /proc/meminfo | awk '{print int($2/1024)}')
    mem_used=$((mem_total - mem_avail))
else
    mem_free=$(grep MemFree /proc/meminfo | awk '{print int($2/1024)}')
    buffers=$(grep Buffers /proc/meminfo | awk '{print int($2/1024)}')
    cached=$(grep Cached /proc/meminfo | awk '{print int($2/1024)}')
    mem_used=$((mem_total - mem_free - buffers - cached))
fi
[ $mem_used -lt 0 ] && mem_used=0
mem_pct=$((mem_used * 100 / (mem_total + 1)))
mem_str="${mem_pct}% of ${mem_total}MB"

color_mem=$GREEN
if [ $mem_pct -ge 85 ]; then
    color_mem=$RED
elif [ $mem_pct -ge 70 ]; then
    color_mem=$YELLOW
fi

# ===================== 存储 =====================
storage_line=$(df -h / 2>/dev/null | tail -n1)
storage_pct=$(echo "$storage_line" | awk '{print $5}' | tr -d '%')
storage_size=$(echo "$storage_line" | awk '{print $2}')
storage_str="${storage_pct}% of ${storage_size}"

color_storage=$GREEN
if [ $storage_pct -ge 90 ]; then
    color_storage=$RED
elif [ $storage_pct -ge 75 ]; then
    color_storage=$YELLOW
fi

# ===================== CPU 信息 =====================
cpu_model=$(grep -m1 "model name" /proc/cpuinfo 2>/dev/null | cut -d: -f2 | sed 's/^ //')
if [ -z "$cpu_model" ]; then
    cpu_model=$(grep -m1 Hardware /proc/cpuinfo 2>/dev/null | cut -d: -f2 | sed 's/^ //')
fi
cpu_cores=$(grep -c processor /proc/cpuinfo 2>/dev/null || echo 1)
[ -z "$cpu_model" ] && cpu_model="未知"

# ===================== 温度 =====================
temp_val=""
has_temp=0
if [ -r /sys/class/thermal/thermal_zone0/temp ]; then
    raw=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
    if [ -n "$raw" ]; then
        if [ "$raw" -gt 1000 ] 2>/dev/null; then
            temp_val=$((raw / 1000))
        else
            temp_val=$raw
        fi
        has_temp=1
    fi
fi

if [ $has_temp -eq 1 ]; then
    if [ $temp_val -gt 70 ]; then
        tcolor=$RED
    elif [ $temp_val -ge 60 ]; then
        tcolor=$YELLOW
    else
        tcolor=$GREEN
    fi
fi

# ===================== 设备信息 =====================
model=$(cat /tmp/sysinfo/model 2>/dev/null || cat /proc/device-tree/model 2>/dev/null | tr -d '\0' | sed 's/[[:space:]]*$//')
model=${model:-未知设备}
arch=$(uname -m)
case "$arch" in
    aarch64) arch_str="aarch64 (ARM64)" ;;
    armv7l)  arch_str="armv7 (ARM32)" ;;
    x86_64)  arch_str="x86_64 (AMD64)" ;;
    *)       arch_str="$arch" ;;
esac

# ===================== 版本 =====================
if [ -f /etc/openwrt_release ]; then
    . /etc/openwrt_release
    dist="${DISTRIB_ID:-OpenWrt} ${DISTRIB_RELEASE:-Unknown}"
else
    dist="ImmortalWrt"
fi
kernel=$(uname -r)

# ===================== 输出 =====================
echo ""
printf " HeiCatWrt 已经持续稳定运行了: %s\n" "$uptime_str"
echo ""
printf " IPv4地址:   ${MAGENTA}%-23s${RESET}    IPv6地址:   ${MAGENTA}%s${RESET}\n" "$lan_ip4" "$lan_ip6"
printf " 系统负载:   ${color_load}%-23s${RESET}    内存占用:   ${color_mem}%s${RESET}\n" "$load" "$mem_str"
printf " 系统存储:   ${color_storage}%-23s${RESET}    CPU 信息:   %s × %s" "$storage_str" "$cpu_model" "$cpu_cores"

if [ $has_temp -eq 1 ]; then
    printf " | ${tcolor}%d°C${RESET}" "$temp_val"
else
    printf " | 无传感器"
fi
printf "\n"

printf " 设备型号:   %-23s    系统架构:   %s\n" "$model" "$arch_str"
printf " 固件版本:   %-23s    内核版本:   %s\n" "$dist" "$kernel"
echo ""
echo "       -----------------------------------------"
echo ""
