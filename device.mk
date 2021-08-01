#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# Init
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.recovery.rc

# Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    kernel/asus/sm8250

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_PACKAGES += \
    FrameworksResCommon_Sys \
    TelephonyResCommon_Sys \
    WifiResCommon_Sys

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Recovery
PRODUCT_PACKAGES += \
    goodix_9896_cfg_group.recovery

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 29

# Vendor
$(call inherit-product, vendor/asus/obiwan/obiwan-vendor.mk)
