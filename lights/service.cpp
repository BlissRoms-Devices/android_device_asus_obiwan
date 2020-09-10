/*
 * Copyright (C) 2018-2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "android.hardware.light@2.0-service.obiwan"

#include <android-base/logging.h>
#include <hidl/HidlTransportSupport.h>

#include "Light.h"

using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;

using android::hardware::light::V2_0::ILight;
using android::hardware::light::V2_0::implementation::Light;

int main() {
    configureRpcThreadpool(1, true /*callerWillJoin*/);

    android::sp<ILight> light = new Light();
    if (light->registerAsService() != android::OK) {
        LOG(ERROR) << "Failed to register Light HAL instance.";
        return 1;
    }

    LOG(INFO) << "Light HAL service is ready.";
    joinRpcThreadpool();
    return 1;  // joinRpcThreadpool shouldn't exit
}
