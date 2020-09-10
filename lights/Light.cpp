/*
 * Copyright (C) 2014, 2017-2018 The  Linux Foundation. All rights reserved.
 * Not a contribution
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (C) 2018-2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "LightsService"

#include <android-base/logging.h>
#include <android-base/stringprintf.h>
#include <fstream>

#include "Light.h"

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

/*
 * Write value to path and close file.
 */
template <typename T>
static void set(const std::string& path, const T& value) {
    std::ofstream file(path);
    file << value;
}

template <typename T>
static T get(const std::string& path, const T& def) {
    std::ifstream file(path);
    T result;

    file >> result;
    return file.fail() ? def : result;
}

static int rgbToBrightness(const LightState& state) {
    int color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0x00ff)) + (150 * ((color >> 8) & 0x00ff)) +
            (29 * (color & 0x00ff))) >>
           8;
}

Light::Light() {
    mLights.emplace(Type::BATTERY, std::bind(&Light::handleRgb, this, std::placeholders::_1, 1));
    mLights.emplace(Type::BACKLIGHT,
                    std::bind(&Light::handleBacklight, this, std::placeholders::_1));
}

void Light::handleBacklight(const LightState& state) {
    int maxBrightness = get("/sys/class/backlight/panel0-backlight/max_brightness", -1);
    if (maxBrightness < 0) {
        maxBrightness = 4095;
    }
    int sentBrightness = rgbToBrightness(state);
    int brightness = sentBrightness * maxBrightness / 255;
    LOG(DEBUG) << "Writing backlight brightness " << brightness << " (orig " << sentBrightness
               << ")";
    set("/sys/class/backlight/panel0-backlight/brightness", brightness);
}

void Light::handleRgb(const LightState& state, size_t index) {
    mLightStates.at(index) = state;

    LightState stateToUse = mLightStates.front();
    for (const auto& lightState : mLightStates) {
        if (lightState.color & 0xffffff) {
            stateToUse = lightState;
            break;
        }
    }

    std::map<std::string, int> colorValues;
    colorValues["red"] = (stateToUse.color >> 16) & 0xff;
    colorValues["green"] = (stateToUse.color >> 8) & 0xff;

    auto makeLedPath = [](const std::string& led, const std::string& op) -> std::string {
        return "/sys/class/leds/" + led + "/" + op;
    };

    for (const auto& entry : colorValues) {
        set(makeLedPath(entry.first, "brightness"), entry.second);
    }

    LOG(DEBUG) << base::StringPrintf(
            "handleRgb: mode=%d, color=%08X",
            static_cast<std::underlying_type<Flash>::type>(stateToUse.flashMode), stateToUse.color);
}

Return<Status> Light::setLight(Type type, const LightState& state) {
    auto it = mLights.find(type);

    if (it == mLights.end()) {
        return Status::LIGHT_NOT_SUPPORTED;
    }

    /*
     * Lock global mutex until light state is updated.
     */
    std::lock_guard<std::mutex> lock(mLock);

    it->second(state);

    return Status::SUCCESS;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types;

    for (auto const& light : mLights) {
        types.push_back(light.first);
    }

    _hidl_cb(types);

    return Void();
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
