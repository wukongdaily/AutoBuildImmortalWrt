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



> ### ~~GL-iNet 和 Cudy MediaTek Filogic 工作流~~ 归入build-wireless-router.yml 

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

>  ### MediaTek 路由器工作流（大约103种）build-wireless-router.yml 

| 机型 | 机型 | 机型 |
|------|------|------|
| abt_asr3000 | acelink_ew-7886cax | acer_predator-w6 |
| acer_predator-w6d | acer_vero-w6m | arcadyan_mozart |
| asus_rt-ax52 | asus_rt-ax59u | asus_tuf-ax4200 |
| asus_tuf-ax6000 | bananapi_bpi-r3 | bananapi_bpi-r3-mini |
| bananapi_bpi-r4 | bananapi_bpi-r4-poe | cetron_ct3003 |
| **cetron_ct3003-stock** | cetron_ct3003-ubootmod | **cmcc_a10** |
| cmcc_a10-stock | cmcc_a10-ubootmod | cmcc_rax3000m |
| **cmcc_rax3000m-emmc-ubootmod** | **cmcc_rax3000m-nand-ubootmod** | cmcc_rax3000me |
| comfast_cf-e393ax | confiabits_mt7981 | cudy_ap3000-v1 |
| cudy_ap3000outdoor-v1 | cudy_m3000-v1 | cudy_re3000-v1 |
| cudy_tr3000-v1 | cudy_tr3000-v1-ubootmod | cudy_wr3000-v1 |
| cudy_wr3000e-v1 | cudy_wr3000h-v1 | cudy_wr3000s-v1 |
| dlink_aquila-pro-ai-m30-a1 | dlink_aquila-pro-ai-m60-a1 | edgecore_eap111 |
| gatonetworks_gdsp | glinet_gl-mt2500 | glinet_gl-mt3000 |
| glinet_gl-mt6000 | glinet_gl-x3000 | glinet_gl-xe3000 |
| h3c_magic-nx30-pro | h3c_magic-nx30-pro-nmbm | huasifei_wh3000-emmc |
| imou_lc-hx3001 | **imou_lc-hx3001-ubootmod** | **jcg_q30** |
| **jcg_q30-ubootmod** | jcg_q30-pro | jdcloud_re-cp-03 |
| keenetic_kn-3811 | keenetic_kn-3911 | konka_komi-a31 |
| livinet_zr-3020 | livinet_zr-3020-ubootmod | mediatek_mt7981-rfb |
| mediatek_mt7986a-rfb-nand | mediatek_mt7986b-rfb | mediatek_mt7988a-rfb |
| mercusys_mr80x-v3 | mercusys_mr90x-v1 | mercusys_mr90x-v1-ubi |
| netcore_n60 | netcore_n60-pro | netgear_wax220 |
| netis_nx31 | nokia_ea0326gmp | openembed_som7981 |
| openwrt_one | qihoo_360t7 | **qihoo_360t7-ubootmod** |
| routerich_ax3000 | routerich_ax3000-ubootmod | routerich_ax3000-v1 |
| ruijie_rg-x60-pro | smartrg_sdg-8612 | smartrg_sdg-8614 |
| smartrg_sdg-8622 | smartrg_sdg-8632 | smartrg_sdg-8733 |
| smartrg_sdg-8733a | smartrg_sdg-8734 | tplink_archer-ax80-v1 |
| tplink_re6000xd | tplink_tl-xdr4288 | tplink_tl-xdr6086 |
| tplink_tl-xdr6088 | tplink_tl-xtr8488 | ubnt_unifi-6-plus |
| unielec_u7981-01-emmc | unielec_u7981-01-nand | wavlink_wl-wn573hx3 |
| wavlink_wl-wn586x3 | xiaomi_mi-router-ax3000t | xiaomi_mi-router-ax3000t-ubootmod |
| xiaomi_mi-router-wr30u-stock | xiaomi_mi-router-wr30u-ubootmod | **xiaomi_mi-router-wr30u-112m-nmbm** |
| xiaomi_redmi-router-ax6000-stock | xiaomi_redmi-router-ax6000-ubootmod | yuncore_ax835 |
| zbtlink_zbt-z8102ax | zbtlink_zbt-z8103ax | zyxel_ex5601-t0-stock |
| zyxel_ex5601-t0-ubootmod | zyxel_ex5700-telenor | zyxel_nwa50ax-pro |


> ### 高通ipq807x 路由器

| 序号 | 机型                | 序号 | 机型                | 序号 | 机型                |
|------|-------------------|------|-------------------|------|-------------------|
| 1    | arcadyan_aw1000    | 12   | linksys_mx5300    | 23   | redmi_ax6-stock    |
| 2    | asus_rt-ax89x      | 13   | linksys_mx8500    | 24   | spectrum_sax1v1k   |
| 3    | buffalo_wxr-5950ax12 | 14 | netgear_rax120v2 | 25   | tplink_eap660hd-v1 |
| 4    | cmcc_rm2-6         | 15   | netgear_sxr80     | 26   | xiaomi_ax3600      |
| 5    | compex_wpq873      | 16   | netgear_sxs80     | 27   | xiaomi_ax3600-stock|
| 6    | dynalink_dl-wrx36  | 17   | netgear_wax218    | 28   | xiaomi_ax9000      |
| 7    | edgecore_eap102    | 18   | netgear_wax620    | 29   | xiaomi_ax9000-stock|
| 8    | edimax_cax1800     | 19   | netgear_wax630    | 30   | yuncore_ax880      |
| 9    | linksys_mx4200v1   | 20   | prpl_haze         | 31   | zbtlink_zbt-z800ax |
| 10   | linksys_mx4200v2   | 21   | qnap_301w         | 32   | zte_mf269          |
| 11   | linksys_mx4300     | 22   | redmi_ax6         | 33   | zte_mf269-stock    |
|      |                   |      |                   | 34   | zyxel_nbg7815      |

> #### MT7621 路由器（267个）

| 机型1                          | 机型2                          | 机型3                             |
| ---------------------------- | ---------------------------- | ------------------------------- |
| adslr\_g7                    | afoundry\_ew1200             | alfa-network\_ax1800rm          |
| alfa-network\_quad-e4g       | ampedwireless\_ally-00x19k   | ampedwireless\_ally-r1900k      |
| arcadyan\_we410443           | arcadyan\_we420223-99        | asiarf\_ap7621-001              |
| asiarf\_ap7621-nv1           | asus\_rp-ac56                | asus\_rp-ac87                   |
| asus\_rt-ac57u-v1            | asus\_rt-ac65p               | asus\_rt-ac85p                  |
| asus\_rt-ax53u               | asus\_rt-ax54                | asus\_rt-n56u-b1                |
| beeline\_smartbox-flash      | beeline\_smartbox-giga       | beeline\_smartbox-pro           |
| beeline\_smartbox-turbo      | beeline\_smartbox-turbo-plus | belkin\_rt1800                  |
| bolt\_arion                  | buffalo\_wsr-1166dhp         | buffalo\_wsr-2533dhpl2          |
| buffalo\_wsr-2533dhpls       | buffalo\_wsr-600dhp          | comfast\_cf-e390ax              |
| comfast\_cf-ew72-v2          | confiabits\_mt7621-v1        | **cudy\_m1300-v2**                  |
| **cudy\_m1800**                  | **cudy\_wr1300-v1**              | **cudy\_wr1300-v2**                 |
| **cudy\_wr1300-v3**              | **cudy\_wr2100**                 | **cudy\_x6-v1**                     |
| **cudy\_x6-v2**                  | d-team\_newifi-d2            | d-team\_pbr-m1                  |
| dlink\_covr-x1860-a1         | dlink\_dap-1620-b1           | dlink\_dap-x1860-a1             |
| dlink\_dir-1935-a1           | dlink\_dir-1960-a1           | dlink\_dir-2055-a1              |
| dlink\_dir-2150-a1           | dlink\_dir-2150-r1           | dlink\_dir-2640-a1              |
| dlink\_dir-2660-a1           | dlink\_dir-3040-a1           | dlink\_dir-3060-a1              |
| dlink\_dir-853-a1            | dlink\_dir-853-a3            | dlink\_dir-853-r1               |
| dlink\_dir-860l-b1           | dlink\_dir-867-a1            | dlink\_dir-878-a1               |
| dlink\_dir-878-r1            | dlink\_dir-882-a1            | dlink\_dir-882-r1               |
| dlink\_dra-1360-a1           | dna\_valokuitu-plus-ex400    | dual-q\_h721                    |
| edimax\_ra21s                | edimax\_re23s                | edimax\_rg21s                   |
| elecom\_wmc-m1267gst2        | elecom\_wmc-s1267gs2         | elecom\_wmc-x1800gst            |
| elecom\_wrc-1167ghbk2-s      | elecom\_wrc-1167gs2-b        | elecom\_wrc-1167gst2            |
| elecom\_wrc-1750gs           | elecom\_wrc-1750gst2         | elecom\_wrc-1750gsv             |
| elecom\_wrc-1900gst          | elecom\_wrc-2533ghbk-i       | elecom\_wrc-2533gs2             |
| elecom\_wrc-2533gst          | elecom\_wrc-2533gst2         | elecom\_wrc-x1800gs             |
| elecom\_wsc-x1800gs          | etisalat\_s3                 | firefly\_firewrt                |
| gehua\_ghl-r-001             | gemtek\_wvrtm-127acn         | gemtek\_wvrtm-130acn            |
| genexis\_pulse-ex400         | **glinet\_gl-mt1300**            | gnubee\_gb-pc1                  |
| gnubee\_gb-pc2               | h3c\_tx1800-plus             | h3c\_tx1801-plus                |
| h3c\_tx1806                  | haier\_har-20s2u1            | hanyang\_hyc-g920               |
| hilink\_hlk-7621a-evb        | hiwifi\_hc5962               | huasifei\_ws1208v2              |
| humax\_e10                   | iodata\_wn-ax1167gr          | iodata\_wn-ax1167gr2            |
| iodata\_wn-ax2033gr          | iodata\_wn-deax1800gr        | iodata\_wn-dx1167r              |
| iodata\_wn-dx1200gr          | iodata\_wn-dx2033gr          | iodata\_wn-gx300gr              |
| iodata\_wnpr2600g            | iptime\_a3002mesh            | iptime\_a3004ns-dual            |
| iptime\_a3004t               | iptime\_a6004ns-m            | iptime\_a6ns-m                  |
| iptime\_a8004t               | iptime\_ax2004m              | iptime\_t5004                   |
| jcg\_jhr-ac876m              | **jcg\_q20**                     | **jcg\_y2**                         |
| **jdcloud\_re-cp-02**            | **jdcloud\_re-sp-01b**           | keenetic\_kn-3010               |
| keenetic\_kn-3510            | lenovo\_newifi-d1            | linksys\_e5600                  |
| linksys\_e7350               | linksys\_ea6350-v4           | linksys\_ea7300-v1              |
| linksys\_ea7300-v2           | linksys\_ea7500-v2           | linksys\_ea8100-v1              |
| linksys\_ea8100-v2           | linksys\_re6500              | linksys\_re7000                 |
| mediatek\_ap-mt7621a-v60     | mediatek\_mt7621-eval-board  | meig\_slt866                    |
| mercusys\_mr70x-v1           | mikrotik\_ltap-2hnd          | mikrotik\_routerboard-750gr3    |
| mikrotik\_routerboard-760igs | mikrotik\_routerboard-m11g   | mikrotik\_routerboard-m33g      |
| mqmaker\_witi                | mtc\_wr1201                  | mts\_wg430223                   |
| netgear\_eax12               | netgear\_ex6150              | netgear\_r6220                  |
| netgear\_r6260               | netgear\_r6350               | netgear\_r6700-v2               |
| netgear\_r6800               | netgear\_r6850               | netgear\_r6900-v2               |
| netgear\_r7200               | netgear\_r7450               | netgear\_wac104                 |
| netgear\_wac124              | netgear\_wax202              | netgear\_wax214v2               |
| netgear\_wndr3700-v5         | netis\_n6                    | netis\_wf2881                   |
| openfi\_5pro                 | oraybox\_x3a                 | phicomm\_k2p                    |
| planex\_vr500                | raisecom\_msg1500-x-00       | renkforce\_ws-wn530hp3-a        |
| rostelecom\_rt-fe-1a         | rostelecom\_rt-sf-1          | ruijie\_rg-ew1200g-pro-v1.1     |
| samknows\_whitebox-v8        | sercomm\_na502               | sercomm\_na502s                 |
| sim\_simax1800t              | snr\_snr-cpe-me1             | snr\_snr-cpe-me2-lite           |
| snr\_snr-cpe-me2-sfp         | storylink\_sap-g3200u3       | telco-electronics\_x1           |
| tenbay\_t-mb5eu-v01          | thunder\_timecloud           | totolink\_a7000r                |
| totolink\_x5000r             | tozed\_zlt-s12-pro           | tplink\_archer-a6-v3            |
| tplink\_archer-ax23-v1       | tplink\_archer-c6-v3         | tplink\_archer-c6u-v1           |
| tplink\_deco-m4r-v4          | tplink\_eap235-wall-v1       | tplink\_eap613-v1               |
| tplink\_eap615-wall-v1       | tplink\_ec330-g5u-v1         | tplink\_er605-v2                |
| tplink\_ex220-v1             | tplink\_mr600-v2-eu          | tplink\_re350-v1                |
| tplink\_re500-v1             | tplink\_re650-v1             | tplink\_re650-v2                |
| tplink\_tl-wpa8631p-v3       | ubnt\_edgerouter-x           | ubnt\_edgerouter-x-sfp          |
| ubnt\_unifi-6-lite           | ubnt\_unifi-flexhd           | ubnt\_unifi-nanohd              |
| ubnt\_usw-flex               | unielec\_u7621-01-16m        | unielec\_u7621-06-16m           |
| unielec\_u7621-06-32m        | unielec\_u7621-06-64m        | wavlink\_wl-wn531a6             |
| wavlink\_wl-wn533a8          | wavlink\_wl-wn573hx1         | wavlink\_ws-wn572hp3-4g         |
| wevo\_11acnas                | wevo\_w2914ns-v2             | wifire\_s1500-nbn               |
| winstars\_ws-wn536p3         | winstars\_ws-wn583a6         | wodesys\_wd-r1802u              |
| **xiaomi\_mi-router-3-pro**      | **xiaomi\_mi-router-3g**         | **xiaomi\_mi-router-3g-v2**         |
| **xiaomi\_mi-router-4**          | **xiaomi\_mi-router-4a-gigabit** | **xiaomi\_mi-router-4a-gigabit-v2** |
| **xiaomi\_mi-router-ac2100**     | **xiaomi\_mi-router-cr6606**     | **xiaomi\_mi-router-cr6608**        |
| **xiaomi\_mi-router-cr6609**     | **xiaomi\_redmi-router-ac2100**  | xiaoyu\_xy-c5                   |
| xzwifi\_creativebox-v1       | youhua\_wr1200js             | youku\_yk-l2                    |
| yuncore\_ax820               | yuncore\_fap640              | yuncore\_fap690                 |
| yuncore\_g720                | z-router\_zr-2660            | zbtlink\_zbt-we1326             |
| zbtlink\_zbt-we3526          | zbtlink\_zbt-wg1602-16m      | zbtlink\_zbt-wg1602-v04-16m     |
| zbtlink\_zbt-wg1602-v04-32m  | zbtlink\_zbt-wg1608-16m      | zbtlink\_zbt-wg1608-32m         |
| zbtlink\_zbt-wg2626          | zbtlink\_zbt-wg3526-16m      | zbtlink\_zbt-wg3526-32m         |
| zio\_freezio                 | zte\_e8820s                  | zyxel\_lte3301-plus             |
| zyxel\_lte5398-m904          | zyxel\_nr7101                | zyxel\_nwa50ax                  |
| zyxel\_nwa55axe              | zyxel\_wap6805               | zyxel\_wsm20                    |



> ### 硬路由固件格式说明

| 文件类型 | 用途        | 内容               | 常用场景             |
| ---- | --------- | ---------------- | ---------------- |
| FIP  | Arm 固件包   | BL1/BL2/BL31 等   | CPU 上电启动         |
| BIN  | 泛二进制      | Bootloader/内核等   | 烧录或加载执行          |
| UBI  | NAND 文件系统 | UBIFS 镜像         | 嵌入式 NAND 路由器/开发板 |
| ITB  | U-Boot 镜像 | 内核+设备树+initramfs | U-Boot 启动镜像      |

