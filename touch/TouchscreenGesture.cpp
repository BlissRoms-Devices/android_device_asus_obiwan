/*
 * Copyright (C) 2022 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "TouchscreenGestureService"

#include "TouchscreenGesture.h"

#include <bitset>
#include <fstream>
#include <map>
#include <type_traits>
#include <vector>
#include <android-base/file.h>

namespace vendor {
namespace lineage {
namespace touch {
namespace V1_0 {
namespace implementation {

const std::string kGesturePath = "/proc/driver/gesture_type";

const std::map<int32_t, TouchscreenGesture::GestureInfo> TouchscreenGesture::kGestureInfoMap = {
    // clang-format off
    {0, {17, "Letter W"}},
    {1, {31, "Letter S"}},
    {2, {18, "Letter e"}},
    {3, {50, "Letter M"}},
    {4, {44, "Letter Z"}},
    {5, {47, "Letter V"}},
    {6, {168, "Left arrow"}},
    {7, {159, "Right arrow"}},
    {8, {119, "Two fingers down swipe"}},
    // clang-format on
};

const uint8_t kGestureControlBit = 0;
const std::vector<int> kGestureBits = {
    1,  // W gesture bit
    2,  // S gesture bit
    3,  // e gesture bit
    4,  // M gesture bit
    5,  // Z gesture bit
    6,  // V gesture bit
    7,  // Music control bit
    7,  // Music control bit
    7,  // Music control bit
};

Return<void> TouchscreenGesture::getSupportedGestures(getSupportedGestures_cb resultCb) {
    std::vector<Gesture> gestures;

    for (const auto& entry : kGestureInfoMap) {
        gestures.push_back({entry.first, entry.second.name, entry.second.keycode});
    }
    resultCb(gestures);

    return Void();
}

Return<bool> TouchscreenGesture::setGestureEnabled(
    const ::vendor::lineage::touch::V1_0::Gesture& gesture, bool enabled) {
    std::bitset<8> gestureMode;
    std::fstream(kGesturePath) >> gestureMode;

    gestureMode[kGestureBits[gesture.id]] = enabled;
    gestureMode[kGestureControlBit] = gestureMode.any();

    return android::base::WriteStringToFile(gestureMode.to_string(), kGesturePath);
}

}  // namespace implementation
}  // namespace V1_0
}  // namespace touch
}  // namespace lineage
}  // namespace vendor
