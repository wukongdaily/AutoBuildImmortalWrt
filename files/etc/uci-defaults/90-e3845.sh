#!/bin/sh
# 90-e385.sh - E3845 平台自定义优化（一次性执行）
# 作用：
#   1. 禁用网卡 HW TC offload（防止 hwtc 异常）
#   2. 在 rc.local 中插入 C-State 和 clocksource 调整（保持当前稳定配置）

# 1) 生成 /etc/hotplug.d/net/10-disable-hwtc
cat <<'EOF' >/etc/hotplug.d/net/10-disable-hwtc
#!/bin/sh
# 自动关闭所有网口的硬件流量控制(hardware tc offload)

[ "$ACTION" = "ifup" ] || exit 0
[ -n "$DEVICE" ] || exit 0

# 某些平台可能没有 ethtool，忽略错误即可
if command -v ethtool >/dev/null 2>&1; then
    ethtool --offload "$DEVICE" hw-tc-offload off 2>/dev/null
fi

exit 0
EOF

chmod +x /etc/hotplug.d/net/10-disable-hwtc

# 2) 在 /etc/rc.local 中插入 C-State & clocksource 调整
#    加上标记，避免重复插入

MARK="E385-tuning-start"

if ! grep -q "$MARK" /etc/rc.local 2>/dev/null; then
    sed -i '/^exit 0$/i \
# '"$MARK"'\n\
# 限制 intel_idle C-State，维持和当前 BIOS 设置配合的稳定状态\n\
[ -f /sys/devices/system/cpu/intel_idle/max_cstate ] && echo 1 > /sys/devices/system/cpu/intel_idle/max_cstate 2>/dev/null\n\
[ -f /sys/module/intel_idle/parameters/max_cstate ] && echo 1 > /sys/module/intel_idle/parameters/max_cstate 2>/dev/null\n\
# 将时钟源切到 acpi_pm，避免 TSC 在该平台上的不稳定问题\n\
if [ -w /sys/devices/system/clocksource/clocksource0/current_clocksource ]; then\n\
    echo acpi_pm > /sys/devices/system/clocksource/clocksource0/current_clocksource 2>/dev/null\n\
fi\n\
# E385-tuning-end\n' /etc/rc.local
fi

exit 0
