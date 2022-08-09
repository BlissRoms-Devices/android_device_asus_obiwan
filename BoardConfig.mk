#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/asus/obiwan

include build/make/target/board/BoardConfigMainlineCommon.mk

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system

# AVB
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_VBMETA_SYSTEM := product system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

# Bluetooth
TARGET_USE_QTI_BT_STACK := true

# DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 2
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := \
    androidboot.console=ttyMSM0 \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    cgroup.memory=nokmem,nosocket \
    console=ttyMSM0,115200n8 \
    earlycon=msm_geni_serial,0xa90000 \
    loop.max_part=7 \
    lpm_levels.sleep_disabled=1 \
    msm_rtb.filter=0x237 \
    reboot=panic_warm \
    service_locator.enable=1 \
    swiotlb=2048 \
    video=vfb:640x400,bpp=32,memsize=3072000
BOARD_KERNEL_PAGESIZE := 4096

BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_ADDITIONAL_FLAGS := ASUS_BUILD_PROJECT=ZS661KS
TARGET_KERNEL_CONFIG := vendor/ZS661KS-perf_defconfig
TARGET_KERNEL_SOURCE := kernel/asus/sm8250

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
TARGET_MODULE_ALIASES := \
    adsp_loader_dlkm.ko:audio_adsp_loader.ko \
    apr_dlkm.ko:audio_apr.ko \
    bolero_cdc_dlkm.ko:audio_bolero_cdc.ko \
    hdmi_dlkm.ko:audio_hdmi.ko \
    machine_dlkm.ko:audio_machine_kona.ko \
    mbhc_dlkm.ko:audio_mbhc.ko \
    native_dlkm.ko:audio_native.ko \
    pinctrl_lpi_dlkm.ko:audio_pinctrl_lpi.ko \
    pinctrl_wcd_dlkm.ko:audio_pinctrl_wcd.ko \
    platform_dlkm.ko:audio_platform.ko \
    q6_dlkm.ko:audio_q6.ko \
    q6_notifier_dlkm.ko:audio_q6_notifier.ko \
    q6_pdr_dlkm.ko:audio_q6_pdr.ko \
    rx_macro_dlkm.ko:audio_rx_macro.ko \
    snd-soc-rt5683.ko:audio_rt5683.ko \
    snd_event_dlkm.ko:audio_snd_event.ko \
    stub_dlkm.ko:audio_stub.ko \
    swr_ctrl_dlkm.ko:audio_swr_ctrl.ko \
    swr_dlkm.ko:audio_swr.ko \
    tfa9874_dlkm.ko:audio_tfa9874.ko \
    tx_macro_dlkm.ko:audio_tx_macro.ko \
    usf_dlkm.ko:audio_usf.ko \
    va_macro_dlkm.ko:audio_va_macro.ko \
    wcd938x_dlkm.ko:audio_wcd938x.ko \
    wcd938x_slave_dlkm.ko:audio_wcd938x_slave.ko \
    wcd9xxx_dlkm.ko:audio_wcd9xxx.ko \
    wcd_core_dlkm.ko:audio_wcd_core.ko \
    wlan.ko:qca_cld3_qca6390.ko \
    wsa_macro_dlkm.ko:audio_wsa_macro.ko

# Partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := product system system_ext
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 12884901888

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x6000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x1800000
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x6400000

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

# Platform
BOARD_USES_QCOM_HARDWARE := true

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
