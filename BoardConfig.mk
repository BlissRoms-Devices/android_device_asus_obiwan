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

# Inherit from asus sm8250-common
-include device/asus/sm8250-common/BoardConfigCommon.mk

DEVICE_PATH := device/asus/obiwan
SELINUX_IGNORE_NEVERALLOWS := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

# Build
BUILD_BROKEN_DUP_RULES := true

# Kernel
TARGET_KERNEL_CONFIG := vendor/obiwan_defconfig

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop

# Recovery
TARGET_RECOVERY_DEVICE_DIRS :=$(DEVICE_PATH)/recovery

# Vendor init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_obiwan
TARGET_RECOVERY_DEVICE_MODULES := libinit_obiwan

# Security patch level
VENDOR_SECURITY_PATCH := 2021-09-01

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# inherit from the proprietary version
-include vendor/asus/obiwan/BoardConfigVendor.mk
