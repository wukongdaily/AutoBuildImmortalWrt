#!/bin/sh
# 90-e3845.sh - E3845 平台调优脚本

# 创建 /etc/init.d/e3845-tune
cat <<'EOF' >/etc/init.d/e3845-tune
#!/bin/sh /etc/rc.common

START=99
STOP=10

start() {
    # cstate只允许到 C1，禁用深度 C 状态
    if [ -f /sys/devices/system/cpu/intel_idle/max_cstate ]; then
        echo 1 > /sys/devices/system/cpu/intel_idle/max_cstate 2>/dev/null
    fi
    if [ -f /sys/module/intel_idle/parameters/max_cstate ]; then
        echo 1 > /sys/module/intel_idle/parameters/max_cstate 2>/dev/null
    fi

    for cpu in /sys/devices/system/cpu/cpu[0-9]* ; do
        for s in 2 3 4 5 6 7 8 9; do
            p="$cpu/cpuidle/state${s}/disable"
            [ -w "$p" ] && echo 1 > "$p" 2>/dev/null
        done
    done

    # 关闭所有物理网口的 hw-tc-offload
    if command -v ethtool >/dev/null 2>&1; then
        for iface in /sys/class/net/eth* ; do
            dev=$(basename "$iface")
            if ethtool -k "$dev" 2>/dev/null | grep -q 'hw-tc-offload: on'; then
                ethtool --offload "$dev" hw-tc-offload off 2>/dev/null
            fi
        done
    fi

    # 时钟源切换为 acpi_pm
    CS="/sys/devices/system/clocksource/clocksource0/current_clocksource"
    if [ -w "$CS" ]; then
        cur_cs="$(cat "$CS" 2>/dev/null)"
        [ "$cur_cs" != "acpi_pm" ] && echo acpi_pm > "$CS" 2>/dev/null
    fi

    # 禁用 flow offload 相关模块
    for m in nft_flow_offload nf_flow_table_inet nf_flow_table; do
        if lsmod | grep -q "^$m"; then
            rmmod "$m" 2>/dev/null
        fi
    done
}

stop() {
    return 0
}
EOF

chmod +x /etc/init.d/e3845-tune
/etc/init.d/e3845-tune enable >/dev/null 2>&1
/etc/init.d/e3845-tune start  >/dev/null 2>&1

exit 0
