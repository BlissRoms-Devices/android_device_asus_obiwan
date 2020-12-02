#
# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS661KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS661KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes_ZS661KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes_ZS661KS.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

# Display
PRODUCT_PACKAGES += \
    FrameRateTile

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/goodix_ts.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/goodix_ts.idc \
    $(LOCAL_PATH)/idc/goodix_ts_station.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/goodix_ts_station.idc \
    $(LOCAL_PATH)/keychars/goodix_ts.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/goodix_ts.kcm \
    $(LOCAL_PATH)/keylayout/goodix_ts.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/goodix_ts.kl

# Touch
PRODUCT_PACKAGES += \
    vendor.lineage.touch@1.0-service.asus_kona

PRODUCT_SHIPPING_API_LEVEL := 29

# Inherit from asus sm8250-common
$(call inherit-product, device/asus/sm8250-common/common.mk)

# Inherit from vendor blobs
$(call inherit-product, vendor/asus/obiwan/obiwan-vendor.mk)
