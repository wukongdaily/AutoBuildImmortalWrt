# 本项目支持的机型列表

>  ### x86-64 工作流

| 🖥️ 工作流分类            | 处理器            | 备注         | luci版本        |
| ---------------- | -------------- | ---------- |---------- |
| x86-64 efi.img.gz  | Intel/AMD | EFI向下兼容传统BIOS |24.10.x |
| x86-64 OpenWrt安装器   | Intel/AMD | ISO格式适用于任何虚拟机和任何物理机 引导后输入ddd来安装 |24.10.x |

> ### QEMU-qcow2 ARM-64 工作流
- 你可以理解为这是一种ARM64平台下通用型OpenWrt ,产出格式为qcow2,适合所有ARM64平台的虚拟机
- 比如斐讯N1刷了armbian系统,armbian系统里安装了PVE虚拟机 可用
- 比如新款Apple Silicon芯片的苹果电脑里的虚拟机UTM 可用
- 比如友善NanoPi R3S、R5S 官方推出的预装了PVE的debian系统 可用
- 比如瑞莎E20C刷了Armbian系统，自己安装了QEMU+KVM虚拟机 可用

>  ### Rockchip 工作流
| 📦 工作流分类     | 型号                             | 厂商             | 处理器型号 | luci版本   |
|------------------|----------------------------------|------------------|-------------|------------|
| Rockchip瑞芯微    | ariaboard_photonicat             | Ariaboard        | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | armsom_sige3                     | Armsom           | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | armsom_sige7                     | Armsom           | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | cyber_cyber3588-aib              | Cyber            | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | ezpro_mrkaio-m68s                | EZPro            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | firefly_roc-rk3328-cc            | Firefly          | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | firefly_roc-rk3568-pc            | Firefly          | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopc-t4            | FriendlyARM      | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopc-t6            | FriendlyARM      | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r2c           | FriendlyARM      | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r2c-plus      | FriendlyARM      | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r2s           | FriendlyARM      | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r3s           | FriendlyARM      | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r4s           | FriendlyARM      | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r4se          | FriendlyARM      | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r4s-enterprise| FriendlyARM      | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r5c           | FriendlyARM      | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r5s           | FriendlyARM      | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r6c           | FriendlyARM      | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | friendlyarm_nanopi-r6s           | FriendlyARM      | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | huake_guangmiao-g4c              | Huake            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | lunzn_fastrhino-r66s             | Lunzn            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | lunzn_fastrhino-r68s             | Lunzn            | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | lyt_t68m                         | LYT              | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | pine64_rock64                    | Pine64           | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | pine64_rockpro64                 | Pine64           | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | radxa_cm3_io                     | Radxa            | RK3566      | 24.10.x    |
| Rockchip瑞芯微    | radxa_e25                        | Radxa            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-3a                    | Radxa            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-3b                    | Radxa            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-3c                    | Radxa            | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-5a                    | Radxa            | RK3588S     | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-5b                    | Radxa            | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-pi-4a                 | Radxa            | RK3399      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-pi-e                  | Radxa            | RK3328      | 24.10.x    |
| Rockchip瑞芯微    | radxa_rock-pi-s                  | Radxa            | RK3308      | 24.10.x    |
| Rockchip瑞芯微    | radxa_zero-3e                    | Radxa            | RK3566      | 24.10.x    |
| Rockchip瑞芯微    | radxa_zero-3w                    | Radxa            | RK3566      | 24.10.x    |
| Rockchip瑞芯微    | sinovoip_bpi-r2-pro              | SinoVoip         | RK3568      | 24.10.x    |
| Rockchip瑞芯微    | xunlong_orangepi-5               | OrangePi          | RK3588S     | 24.10.x    |
| Rockchip瑞芯微    | xunlong_orangepi-5-plus          | OrangePi          | RK3588      | 24.10.x    |
| Rockchip瑞芯微    | xunlong_orangepi-r1-plus         | OrangePi          | RK3328        | 24.10.x    |
| Rockchip瑞芯微    | xunlong_orangepi-r1-plus-lts     | OrangePi          | RK3328        | 24.10.x    |

> ### 树莓派1-5 工作流
| 📦 开发板分类     | 型号               | 厂商        | 处理器型号        | luci版本   |
|------------------|--------------------|-------------|-------------------|------------|
| Broadcom博通     | raspberrypi_1_model_b     | Raspberry Pi | BCM2835 (ARMv6)   | 24.10.x    |
| Broadcom博通     | raspberrypi_2_model_b     | Raspberry Pi | BCM2836 (ARMv7)   | 24.10.x    |
| Broadcom博通     | raspberrypi_3_model_b     | Raspberry Pi | BCM2837 (ARM Cortex-A53) | 24.10.x |
| Broadcom博通     | raspberrypi_3_model_b_plus| Raspberry Pi | BCM2837B0         | 24.10.x    |
| Broadcom博通     | raspberrypi_4_model_b     | Raspberry Pi | BCM2711 (Cortex-A72) | 24.10.x |
| Broadcom博通     | raspberrypi_5             | Raspberry Pi | BCM2712 (Cortex-A76 + RPI RP1) | 24.10.x |

> ### 全志Allwinner-sunxi-cortexa53 工作流

| 📦 工作流分类        | 型号                        | 厂商          | 处理器型号     | luci版本   |
|-----------------------|-----------------------------|---------------|----------------|------------|
| sunxi-cortexa53       | xunlong_orangepi-zero3      | OrangePi      | H618           | 24.10.x    |
| sunxi-cortexa53       | friendlyarm_nanopi-r1s-h5   | FriendlyARM   | H5             | 24.10.x    |
| sunxi-cortexa53       | xunlong_orangepi-zero2      | OrangePi      | H616           | 24.10.x    |
| sunxi-cortexa53       | xunlong_orangepi-zero-plus  | OrangePi      | H5             | 24.10.x    |
| sunxi-cortexa53       | friendlyarm_nanopi-neo2     | FriendlyARM   | H5             | 24.10.x    |
| sunxi-cortexa53       | xunlong_orangepi-pc2        | OrangePi      | H5             | 24.10.x    |
| sunxi-cortexa53       | friendlyarm_nanopi-neo-plus2| FriendlyARM   | H5             | 24.10.x    |
| sunxi-cortexa53       | libretech_all-h3-cc-h5      | Libre Computer| H5             | 24.10.x    |
| sunxi-cortexa53       | pine64_pine64-plus          | Pine64        | A64            | 24.10.x    |
| sunxi-cortexa53       | pine64_sopine-baseboard     | Pine64        | A64            | 24.10.x    |



> ### GL-iNet 和 Cudy MediaTek Filogic 工作流

| 📦 SoC平台                         | 型号                           | 厂商       | 处理器型号     | luci版本   |
|-----------------------------------|--------------------------------|------------|----------------|------------|
| MediaTek Filogic (MT7981B, Quad-core Cortex-A53 @1.3GHz) | glinet_gl-mt3000        | GL.iNet    | MT7981B        | 24.10.x    |
| MediaTek Filogic (MT7981B, Quad-core Cortex-A53 @1.3GHz) | glinet_gl-mt2500        | GL.iNet    | MT7981B        | 24.10.x    |
| MediaTek Filogic (MT7986A, Quad-core Cortex-A53 @1.3GHz) | glinet_gl-mt6000        | GL.iNet    | MT7986A        | 24.10.x    |
| Qualcomm IPQ4019 (Quad-core Cortex-A7 @717MHz)           | glinet_gl-b2200         | GL.iNet    | IPQ4019        | 24.10.x    |
| MediaTek Filogic (MT7981B, Quad-core Cortex-A53 @1.3GHz) | cudy_tr3000-v1          | Cudy       | MT7981B        | 24.10.x    |
| MediaTek Filogic (MT7981B, Quad-core Cortex-A53 @1.3GHz) | cudy_tr3000-v1-ubootmod | Cudy       | MT7981B        | 24.10.x    |
| MediaTek Filogic (MT7981B, Quad-core Cortex-A53 @1.3GHz) | cudy_tr3000-256mb-v1    | Cudy       | MT7981B        | 24.10.x    |

> ### 以下设备并非 OpenWrt 官方支持，但可通过 Flippy 打包工具二次生成img 的工作流

| 📦 启动方式 / 分类            | 型号       | 厂商      | 处理器/芯片组        | 说明          |
| ----------------------- | -------- | ------- | -------------- | ----------- |
| Flippy兼容设备（armsr-armv8） | e20c     | Radxa   | RK3528A     | 需Flippy工具打包 |
| Flippy兼容设备（armsr-armv8） | e24c     | Radxa   | RK3528A        | 需Flippy工具打包 |
| Flippy兼容设备（armsr-armv8） | e25      | Radxa   | RK3568        | OpenWrt官方支持/Flippy工具打包 |
| Flippy兼容设备（armsr-armv8） | e52c     | Radxa     | RK3582        | 需Flippy工具打包 |
| Flippy兼容设备（armsr-armv8） | e54c     | Radxa     | RK3582        | 需Flippy工具打包 |
| Flippy兼容设备（armsr-armv8） | rock5b   | Radxa   | RK3588         | 高性能SBC      |
| Flippy兼容设备（armsr-armv8） | rock5c   | Radxa   | RK3588S        | 紧凑型版本       |
| Flippy兼容设备（armsr-armv8） | r66s     | Lunzn   | RK3568         | OpenWrt官方支持/lunzn_fastrhino-r66s        |
| Flippy兼容设备（armsr-armv8） | r68s     | Lunzn   | RK3568         | OpenWrt官方支持/lunzn_fastrhino-r68s         |
| Flippy兼容设备（armsr-armv8） | ht2      | 未明确     | RK3328       | TV盒子类       |
| Flippy兼容设备（armsr-armv8） | h28k     | HINLINK | Amlogic S905X3 | 电视盒子        |
| Flippy兼容设备（armsr-armv8） | h66k     | HINLINK | Amlogic S922X  |             |
| Flippy兼容设备（armsr-armv8） | h68k     | HINLINK | Amlogic S922X  |             |
| Flippy兼容设备（armsr-armv8） | h69k     | HINLINK | Amlogic S922X  |             |
| Flippy兼容设备（armsr-armv8） | h69k-max | HINLINK | Amlogic S922X  | Max版本，扩展内存  |
| Flippy兼容设备（armsr-armv8） | h88k     | HINLINK | Amlogic S922X  |             |
| Flippy兼容设备（armsr-armv8） | h88k-v3  | HINLINK | Amlogic S922X  | 第三版本        |
| Flippy兼容设备（armsr-armv8） | jp-tvbox | 未明确     | Amlogic S905X3 | 电视盒改装       |
| Flippy兼容设备（armsr-armv8） | l1pro    | 未明确     | RK3588S        | 小型软路由       |
| Flippy兼容设备（armsr-armv8） | s905     | 多厂商     | Amlogic S905   | 早期电视盒芯片     |
| Flippy兼容设备（armsr-armv8） | s905x2   | 多厂商     | Amlogic S905X2 |             |
| Flippy兼容设备（armsr-armv8） | s905x3   | 多厂商     | Amlogic S905X3 |             |
| Flippy兼容设备（armsr-armv8） | s912     | 多厂商     | Amlogic S912   |             |
| Flippy兼容设备（armsr-armv8） | s922x    | 多厂商     | Amlogic S922X  | Odroid N2芯片 |
| Flippy兼容设备（armsr-armv8） | s922x-n2 | Odroid  | Amlogic S922X  | 高兼容性设备      |

> ### 斐讯N1 电视盒子
> 构建的是armsr-armv8的rootfs Flippy打包工具打包为OpenWrt镜像<br>
> 用户基数比较庞大 所以我是单独一个工作流 build-n1.yml 支持根据具体 特定内核版本来构建

### 晶晨电视盒子类和部分开发板
> a311d, a311d-oes, s922x-oes-plus, wxy-oect, wxy-oect-replaced, panther-x2, jp-tvbox, s905x3-hk1, tanix-tx6, s905l-b860av21u, s905l2-e900v21e, s905l, s905l-aurora-1s, s905l-mg101, s905l2, s905l2-wojia, s905l3, s905l3-cm211, s905l3-unt400g1, s905l3-unt402a, s905l3a, s905l3a-cm311, s905l3a-m401a, s905l3b, s905l3b-e900v21d, s905l3b-e900v22d, s905l3b-e900v22e, s905l3b-ip103h, s905l3b-rg020et-ca, s905l3b-unt403a, s905lb-ipbs9505, s905lb-q96-mini, s905lb-r3300l, r66s, r68s, nanopc-t6, nanopi-r5c, nanopi-r5s, orangepi-5-plus, orangepi-5b, alark35-3500, anas3035, beikeyun, chainedbox, crrc, dc-a588, dg3399, dg-tn3568, dlfr100, e20c, e25, eaidk-610, emb3531, fine3399, firefly-rk3399, fmx1-pro, h28k, h66k, h68k, h69k, h88k, h88k-v3, h96-max-m2, hs530r, hugsun-x99, ipc-r, king3399, kylin3399, lckfb-tspi, leez, lx-r3s, mrkaio-m68s, renegade-rk3328, rk3318-box, rock5b, rock5c, ruisen-box, s905, s905-beelink-mini, s905-mxqpro-plus, s905d-ki-pro, s905d-sml5442tw, s905mb, s905w, s905w-w95, s905w-x96-mini, s905w-x96w, s905x, s905x-b860h, s905x-nexbox-a95x, s905x-t95, s905x-tbee, s905x-tx9, s905x2, s905x2-km3, s905x2-x96max-2g, s905x3, s905x3-2101, s905x3-a100, s905x3-a95xf3, s905x3-a95xf3-gb, s905x3-b, s905x3-h96max, s905x3-ip1001m, s905x3-q1, s905x3-q2, s905x3-tx3, s905x3-tx3-bz, s905x3-ugoosx3, s905x3-whale, s905x3-x88-pro-x3, s905x3-x96air, s905x3-x96air-gb, s905x3-x96max, s912, s912-h96pro-plus, s912-m8s-pro, s912-nexbox-a1, s912-nexbox-a2, s912-onecloudpro, s912-phicomm-t1, s912-t95z-plus, s912-tx8-max, s912-tx9-pro-2g, s912-tx9-pro-3g, s912-x92, s912-zyxq-fake, s922x, s922x-ct2000, s922x-gtking, s922x-gtkingpro-h, s922x-odroid-n2, s922x-reva, s922x-ugoos-am6, seewo-sv21, smart-am40, smart-am60, station-m1, station-m2, sv-33a6x, swan1-w28, sw799, tb-ls3399, tn3399, tpm312, tqc-a01, tvi3315a, vplus, xiaobao, yskj, zcube1-max, zk-r39a, zysj
