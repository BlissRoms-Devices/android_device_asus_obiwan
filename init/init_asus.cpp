/*
 * Copyright (C) 2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <fstream>
#include <unistd.h>
#include <vector>

#include <android-base/logging.h>
#include <android-base/properties.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <sys/sysinfo.h>

#include "vendor_init.h"

using ::android::base::GetProperty;

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties()
{
    property_override("ro.build.description","sunfish-user 11 RQ3A.210705.001 7380771 release-keys");
    property_override("ro.bootimage.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.odm.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.product.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.system.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.system_ext.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.vendor.build.fingerprint","google/sunfish/sunfish:11/RQ3A.210705.001/7380771:user/release-keys");
    property_override("ro.oem_unlock_supported", "0");
    property_override("ro.boot.verifiedbootstate", "green");
    property_override("ro.boot.flash.locked", "1");
    property_override("ro.boot.veritymode", "enforcing");
    property_override("ro.boot.vbmeta.device_state", "locked");
}

