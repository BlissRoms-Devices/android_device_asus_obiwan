#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from these products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/asus/obiwan/device.mk)

# Inherit from the bliss configuration.
$(call inherit-product, vendor/bliss/config/common_full_phone.mk)

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

# UDFPS Animations
EXTRA_UDFPS_ANIMATIONS := true

PRODUCT_BRAND := asus
PRODUCT_DEVICE := obiwan
PRODUCT_MANUFACTURER := asus
PRODUCT_MODEL := ASUS_I003DD
PRODUCT_NAME := bliss_obiwan

PRODUCT_GMS_CLIENTID_BASE := android-asus

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=ASUS_I003_1 \
    TARGET_PRODUCT=WW_I003D \
    PRIVATE_BUILD_DESC="WW_I006D-user 12 SKQ1.210821.001 31.0210.0210.236-0 release-keys"

BUILD_FINGERPRINT := asus/WW_I003D/ASUS_I003_1:12/SKQ1.210821.001/31.0210.0210.236-0:user/release-keys
