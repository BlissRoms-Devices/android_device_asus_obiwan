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

namespace {
template <typename T>
std::enable_if_t<std::is_integral<T>::value, std::string> encode_binary(T i) {
    return std::bitset<sizeof(T) * 8>(i).to_string();
}
}  // anonymous namespace

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

const uint8_t kKeyMaskGestureControl = 1 << 0;
const std::vector<uint8_t> kGestureMasks = {
    1 << 1,  // W gesture mask
    1 << 2,  // S gesture mask
    1 << 3,  // e gesture mask
    1 << 4,  // M gesture mask
    1 << 5,  // Z gesture mask
    1 << 6,  // V gesture mask
    1 << 7,  // Music control mask
    1 << 7,  // Music control mask
    1 << 7,  // Music control mask
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
    uint8_t gestureMode;
    uint8_t mask = kGestureMasks[gesture.id];
    std::fstream file(kGesturePath);
    file >> gestureMode;

    if (enabled)
        gestureMode |= mask;
    else
        gestureMode &= ~mask;

    if (gestureMode != 0) gestureMode |= kKeyMaskGestureControl;

    file << encode_binary(gestureMode);

    return !file.fail();
}

}  // namespace implementation
}  // namespace V1_0
}  // namespace touch
}  // namespace lineage
}  // namespace vendor
