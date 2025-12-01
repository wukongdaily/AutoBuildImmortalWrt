#!/bin/sh
# 90-e3845.sh - E3845 平台自定义优化（一次性执行）
# 作用：
#   1. 禁用网卡 HW TC offload
#   2. 创建 /etc/init.d/e3845-tune：
#        - 限制 C-State
#        - 将时钟源切到 acpi_pm
#        - 启动时自动禁用 Flow Offload 模块

# 1) 生成 /etc/hotplug.d/net/10-disable-hwtc
cat <<'EOF' >/etc/hotplug.d/net/10-disable-hwtc
#!/bin/sh
# 自动关闭所有物理网口的硬件流量控制 (hw-tc-offload)

command -v ethtool >/dev/null 2>&1 || exit 0

for iface in /sys/class/net/eth*; do
    dev=$(basename "$iface")
    if ethtool -k "$dev" 2>/dev/null | grep -q 'hw-tc-offload: on'; then
        ethtool --offload "$dev" hw-tc-offload off 2>/dev/null
    fi
done

exit 0
EOF

chmod +x /etc/hotplug.d/net/10-disable-hwtc

# 2) 生成 /etc/init.d/e3845-tune
cat <<'EOF' >/etc/init.d/e3845-tune
#!/bin/sh /etc/rc.common

START=99
STOP=10

start() {
    # 1) 限制 intel_idle C-State
    if [ -f /sys/devices/system/cpu/intel_idle/max_cstate ]; then
        echo 1 > /sys/devices/system/cpu/intel_idle/max_cstate 2>/dev/null
    fi
    if [ -f /sys/module/intel_idle/parameters/max_cstate ]; then
        echo 1 > /sys/module/intel_idle/parameters/max_cstate 2>/dev/null
    fi

    #   state2 及以上全部 disable 掉
    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        for s in 2 3 4 5 6 7 8 9; do
            p="$cpu/cpuidle/state${s}/disable"
            [ -w "$p" ] && echo 1 > "$p" 2>/dev/null
        done
    done

    # 2) 将时钟源切到 acpi_pm
    CS_PATH=/sys/devices/system/clocksource/clocksource0
    if [ -r "$CS_PATH/current_clocksource" ] && \
       [ -w "$CS_PATH/current_clocksource" ]; then
        cur_cs="$(cat "$CS_PATH/current_clocksource" 2>/dev/null)"
        [ "$cur_cs" != "acpi_pm" ] && echo acpi_pm > "$CS_PATH/current_clocksource" 2>/dev/null
    fi

    # 3) 禁用 Flow Offload 模块
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

# 3) 启用并立即执行一次
/etc/init.d/e3845-tune enable 2>/dev/null
/etc/init.d/e3845-tune start  2>/dev/null

exit 0
