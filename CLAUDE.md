# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is **not** a buildable codebase that runs locally. It is a collection of GitHub Actions workflows, shell scripts, and config files that drive ImmortalWrt's official `imagebuilder` Docker image to produce customized firmware. All real "builds" happen on GitHub-hosted runners via `workflow_dispatch`. Cloning the repo and running `make` locally is not a supported flow — there is no top-level Makefile, no test suite, and no lint config.

The user-facing entry point is the **GitHub Actions tab**: a user forks the repo, picks a workflow under `.github/workflows/build-*.yml`, fills in the form (firmware size, LuCI version, docker yes/no, optional PPPoE), and the workflow runs the matching `build*.sh` inside the official ImmortalWrt imagebuilder container.

## Architecture: how a build is wired together

Every target follows the same three-layer pattern. Knowing this saves reading every workflow file:

1. **Workflow YAML** (`.github/workflows/build-<target>-<version>.yml`) — defines the form inputs and runs `docker run immortalwrt/imagebuilder:<target>-openwrt-<version>`, mounting:
   - `<target>/imm.config` or `imm25.config` → `/home/build/immortalwrt/.config` (controls which packages the imagebuilder pulls)
   - `<target>/build<NN>.sh` → `/home/build/immortalwrt/build.sh` (the entrypoint; `NN` is `23` / `24` / `25` matching the LuCI major version)
   - `shell/` → `/home/build/immortalwrt/shell` (shared helpers)
   - `files/` → `/home/build/immortalwrt/files` (the per-firmware overlay; everything in here lands at `/` on the booted router)
   - `custom/` → `/home/build/immortalwrt/files/etc/config` (runner-generated config, e.g. `custom_router_ip.txt`)
   - Form inputs are passed as `-e PROFILE=…`, `-e INCLUDE_DOCKER=…`, `-e ENABLE_PPPOE=…`, etc.

2. **Per-target build script** (`<target>/build<NN>.sh`) — runs **inside the imagebuilder container**, not on the runner. It:
   - Sources `shell/custom-packages.sh` (or `shell/apk-custom-packages.sh` for `25.x`/apk-format targets) to compose `$CUSTOM_PACKAGES`.
   - Writes `/home/build/immortalwrt/files/etc/config/pppoe-settings` from the env vars so the router can pick them up at first boot.
   - For some targets, fetches third-party `.run`/`.apk`/`.ipk` archives (e.g. from `wukongdaily/apk`), runs `shell/apk-prepare-packages.sh` / `shell/prepare-packages.sh` to expand `.run` files via `--target ... --noexec` and copy `*.ipk` into `packages/`.
   - Concatenates a `$PACKAGES` string of `luci-app-*`, themes, `luci-i18n-*-zh-cn`, etc., conditionally appends `luci-i18n-dockerman-zh-cn`, optionally side-loads OpenClash/mihomo cores into `files/`, then calls `make image PROFILE=<profile> PACKAGES="$PACKAGES" FILES=/home/build/immortalwrt/files ROOTFS_PARTSIZE=$PROFILE`.
   - **Note the `$PROFILE` overload**: in workflow YAML and the script's `ROOTFS_PARTSIZE`, `$PROFILE` is the firmware size in MB (the form input). The literal string passed to `make image PROFILE=` is the device profile name (e.g. `"generic"` for x86-64, the device-specific id elsewhere).

3. **First-boot script** (`files/etc/uci-defaults/99-custom.sh`) — runs **on the router itself** the first time the firmware boots. This is where most user-visible behavior lives: WAN/LAN auto-detection by interface count, board-specific WAN ifname overrides (e.g. `radxa,e20c`), reading `/etc/config/pppoe-settings` to set up PPPoE, applying the `custom_router_ip.txt` value the workflow stamped in, opening WAN-zone input firewall (intentional, for first-time WebUI access — README explains the rationale and how end users should re-close it). When you add per-board quirks, edit the `case "$board_name" in` block here.

## Where things live

- `x86-64/`, `rockchip/`, `sunxi-cortexa53/`, `mediatek-filogic/` — share the `build23.sh` / `build24.sh` / `build25.sh` + `imm.config` / `imm25.config` layout. The `25` variant is the apk-format ImmortalWrt 25.12.x line; `23` and `24` are opkg.
- `n1/`, `armsr-armv8/`, `raspberrypi/{23.05.4,24.10}/` — single-version targets, just `build.sh` (+ optionally `imm.config`).
- `glinet/99-custom.sh`, `n1/99-banner.sh` — variant first-boot overrides.
- `shell/custom-packages.sh` — **the file users most often edit**. Long list of commented-out `CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-..."` lines; uncomment to bake a third-party plugin into every firmware. There's a parallel `apk-custom-packages.sh` for the apk-based 25.x targets — keep both in sync when the change applies to both ecosystems.
- `shell/switch_repository.sh` — currently a no-op stub; commented-out logic for swapping `downloads.immortalwrt.org` to a CN mirror. Don't expect it to do anything unless you uncomment it.
- `shell/{prepare,apk-prepare}-packages.sh` — extract `.run` self-extracting archives from `extra-packages/` and stage `.ipk` files into `packages/` for the imagebuilder to consume.
- `model/*.txt`, `<target>/info.md`, `*/makeinfo.txt`, `target.txt` — human reference notes on supported boards / target ids; not consumed by any script.
- `SUPPORT.md`, `PACKAGES.md` — long human-readable supported-device and plugin tables. Treat as docs.

## ISO target is special

`build-iso.yml` and `build-iso-25.12.x.yml` are two-job workflows: `build_immortalwrt` first runs the same x86-64 build as the regular workflow and uploads the `.img.gz` as an artifact; `build_installer_iso` then `git clone`s `wukongdaily/img-installer` and wraps that image into a Debian-live ISO via `img-installer/autobuild/autobuild.sh`. The ISO drops the user into a shell where typing `ddd` invokes the install menu.

## When making changes

- Editing `99-custom.sh` affects every newly-flashed router on first boot — board-specific quirks go in the `case` block, not the default arm.
- Editing `build<NN>.sh` runs every build of that target+version; touching the `make image` line risks breaking all releases. Mirror changes across `build23/24/25.sh` only when the change is version-agnostic — the package universes differ (opkg vs apk), so `luci-i18n-package-manager-zh-cn` exists in 25 and not 24, etc.
- Adding a third-party plugin: append a commented `CUSTOM_PACKAGES="$CUSTOM_PACKAGES …"` line to `shell/custom-packages.sh` (and `apk-custom-packages.sh` if applicable) so users can opt in by uncommenting. Don't enable it by default — flash space on hardware routers is the constraint, called out in the file's header comment.
- The default LAN IP `192.168.100.1` is intentional and surfaces as a workflow input (`custom_router_ip`); it's only meaningful for multi-NIC devices. Single-NIC devices stay on DHCP regardless — `99-custom.sh` decides this from interface count, not config.
- There is no CI lint or test step. Validation = trigger the workflow on a fork.
