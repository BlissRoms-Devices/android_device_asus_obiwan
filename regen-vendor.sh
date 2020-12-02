#!/bin/bash
#
# Copyright (C) 2019 The LineageOS Project
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

VENDOR_SKIP_FILES_DEVICE=(
    # Audio configs
    "etc/audio/audio_policy_configuration.xml"
    "etc/audio_policy_configuration.xml"
    "etc/audio_policy_configuration_ZS661KS.xml"

    # SLA Dual Network
    "app/slaservice/slaservice.apk"
    "bin/hw/vendor.qti.sla.service@1.0-service"
    "bin/slad"
    "etc/init/slad.rc"
    "etc/init/vendor.qti.sla.service@1.0-service.rc"
    "etc/sla/slad.conf"
    "etc/sla/slad_data_iface.conf"
    "etc/sla/slad_num_iface.conf"
    "etc/sla/slmAppUseCase.conf"
    "etc/sla/slm_supported_list.xml"
    "lib64/hw/vendor.qti.sla.service@1.0-impl.so"
    "lib64/vendor.qti.sla.service@1.0.so"
    "lib/hw/vendor.qti.sla.service@1.0-impl.so"
    "lib/vendor.qti.sla.service@1.0.so"

    # Misc hals
    "lib64/vendor.ims.airtrigger@1.0.so"
    "lib64/vendor.ims.airtrigger@1.1.so"
    "lib64/vendor.ims.airtrigger@1.2.so"
    "etc/init/vendor.ims.airtrigger@1.2-service.rc"
    "bin/hw/vendor.ims.airtrigger@1.2-service"
    "lib64/vendor.ims.colortemp@1.0.so"
    "etc/init/vendor.ims.colortemp@1.0-service.rc"
    "bin/hw/vendor.ims.colortemp@1.0-service"
    "lib64/vendor.ims.glovemode@1.0.so"
    "etc/init/vendor.ims.glovemode@1.0-service.rc"
    "bin/hw/vendor.ims.glovemode@1.0-service"
    "lib64/vendor.ims.twinviewdock@1.0.so"
    "etc/init/vendor.ims.twinviewdock@1.0-service.rc"
    "bin/hw/vendor.ims.twinviewdock@1.0-service"
    "lib64/vendor.ims.wifiantennamode@1.0.so"
    "etc/init/vendor.ims.wifiantennamode@1.0-service.rc"
    "bin/hw/vendor.ims.wifiantennamode@1.0-service"
    "lib64/vendor.ims.zenmotion@1.0.so"
    "etc/init/vendor.ims.zenmotion@1.0-service.rc"
    "bin/hw/vendor.ims.zenmotion@1.0-service"
    "lib64/hw/vendor.qti.hardware.auralight@1.0-impl.so"
    "lib64/vendor.qti.hardware.auralight@1.0.so"
    "lib/hw/vendor.qti.hardware.auralight@1.0-impl.so"
    "lib/vendor.qti.hardware.auralight@1.0.so"
    "etc/init/vendor.qti.hardware.auralight@1.0-service.rc"
    "bin/hw/vendor.qti.hardware.auralight@1.0-service"
    "lib64/vendor.qti.hardware.ifaa@2.0.so"
    "etc/init/vendor.qti.hardware.ifaa@2.0-service.rc"
    "bin/hw/vendor.qti.hardware.ifaa@2.0-service"
    "etc/init/vendor.ozoaudio.media.c2@1.0-service.rc"
    "bin/hw/vendor.ozoaudio.media.c2@1.0-service"
    "lib64/hw/vendor.asus.hardware.vibratorcontrol@1.0-impl.so"
    "lib64/vendor.asus.hardware.vibratorcontrol@1.0.so"
    "lib/hw/vendor.asus.hardware.vibratorcontrol@1.0-impl.so"
    "lib/vendor.asus.hardware.vibratorcontrol@1.0.so"
    "etc/init/vendor.asus.hardware.vibratorcontrol@1.0-service.rc"
    "bin/hw/vendor.asus.hardware.vibratorcontrol@1.0-service"
    "lib64/hw/android.hardware.vibrator@1.0-impl.so"
    "lib/hw/android.hardware.vibrator@1.0-impl.so"
    "etc/init/android.hardware.vibrator@1.0-service.rc"
    "bin/hw/android.hardware.vibrator@1.0-service"
)

. ../sm8250-common/regen-vendor.sh "$@"
