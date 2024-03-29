/*
 * Copyright (C) 2015 The CyanogenMod Project
 *               2017-2020 The LineageOS Project
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

package org.blissroms.settings.asusparts.doze;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.UserHandle;
import android.provider.Settings;
import android.util.Log;
import androidx.preference.PreferenceManager;

import android.hardware.display.AmbientDisplayConfiguration;

import static android.provider.Settings.Secure.DOZE_ALWAYS_ON;
import static android.provider.Settings.Secure.DOZE_ENABLED;

public final class DozeUtils {

    private static final String TAG = "DozeUtils";
    private static final boolean DEBUG = false;

    private static final String DOZE_INTENT = "com.android.systemui.doze.pulse";

    static final String ALWAYS_ON_DISPLAY = "always_on_display";

    static final String CATEG_PICKUP_SENSOR = "pickup_sensor";
    static final String CATEG_PROX_SENSOR = "proximity_sensor";
	
    static final String DOZE_ENABLE = "doze_enable";

    static final String GESTURE_PICK_UP_KEY = "gesture_pick_up";
    static final String GESTURE_HAND_WAVE_KEY = "gesture_hand_wave";
    static final String GESTURE_POCKET_KEY = "gesture_pocket";

    private static void startService(Context context) {
        if (DEBUG) Log.d(TAG, "Starting service");
        context.startServiceAsUser(new Intent(context, DozeService.class),
                UserHandle.CURRENT);
    }

    private static void stopService(Context context) {
        if (DEBUG) Log.d(TAG, "Stopping service");
        context.stopServiceAsUser(new Intent(context, DozeService.class),
                UserHandle.CURRENT);
    }

    public static void checkDozeService(Context context) {
        if (isDozeEnabled(context) && !isAlwaysOnEnabled(context) && sensorsEnabled(context)) {
            startService(context);
        } else {
            stopService(context);
        }
    }

    static boolean getProxCheckBeforePulse(Context context) {
        try {
            Context con = context.createPackageContext("com.android.systemui", 0);
            int id = con.getResources().getIdentifier("doze_proximity_check_before_pulse",
                    "bool", "com.android.systemui");
            return con.getResources().getBoolean(id);
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    static void enableDoze(Context context, boolean enable) {
        Settings.Secure.putInt(context.getContentResolver(),
                DOZE_ENABLED, enable ? 1 : 0);
    }

    public static boolean isDozeEnabled(Context context) {
        return Settings.Secure.getInt(context.getContentResolver(),
                DOZE_ENABLED, 1) != 0;
    }

    static void launchDozePulse(Context context) {
        if (DEBUG) Log.d(TAG, "Launch doze pulse");
        context.sendBroadcastAsUser(new Intent(DOZE_INTENT),
                new UserHandle(UserHandle.USER_CURRENT));
    }

    static void enableAlwaysOn(Context context, boolean enable) {
        Settings.Secure.putIntForUser(context.getContentResolver(),
                DOZE_ALWAYS_ON, enable ? 1 : 0, UserHandle.USER_CURRENT);
    }

    static boolean isAlwaysOnEnabled(Context context) {
        final boolean enabledByDefault = context.getResources()
                .getBoolean(com.android.internal.R.bool.config_dozeAlwaysOnEnabled);

        return Settings.Secure.getIntForUser(context.getContentResolver(),
                DOZE_ALWAYS_ON, alwaysOnDisplayAvailable(context) && enabledByDefault ? 1 : 0,
                UserHandle.USER_CURRENT) != 0;
    }

    static boolean alwaysOnDisplayAvailable(Context context) {
        return new AmbientDisplayConfiguration(context).alwaysOnAvailable();
    }

    private static boolean isGestureEnabled(Context context, String gesture) {
        return PreferenceManager.getDefaultSharedPreferences(context)
                .getBoolean(gesture, false);
    }

    static boolean isPickUpEnabled(Context context) {
        return isGestureEnabled(context, GESTURE_PICK_UP_KEY);
    }

    static boolean isHandwaveGestureEnabled(Context context) {
        return isGestureEnabled(context, GESTURE_HAND_WAVE_KEY);
    }

    static boolean isPocketGestureEnabled(Context context) {
        return isGestureEnabled(context, GESTURE_POCKET_KEY);
    }

    private static boolean sensorsEnabled(Context context) {
        return isPickUpEnabled(context) || isHandwaveGestureEnabled(context)
                || isPocketGestureEnabled(context);
    }

    static Sensor getSensor(SensorManager sm, String type) {
        for (Sensor sensor : sm.getSensorList(Sensor.TYPE_ALL)) {
            if (type.equals(sensor.getStringType())) {
                return sensor;
            }
        }
        return null;
    }
}
