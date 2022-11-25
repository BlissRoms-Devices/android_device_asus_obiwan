/*
 * Copyright (C) 2020 The LineageOS Project
 * Copyright (C) 2022 The BlissRoms Project
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
package org.blissroms.settings.asusparts.util;

import android.app.KeyguardManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.UserHandle;

import java.util.List;

import org.blissroms.settings.asusparts.touch.*;

public class ActionUtils {

    private static Intent getLaunchableIntent(Context context, Intent intent) {
        PackageManager pm = context.getPackageManager();
        List<ResolveInfo> resInfo = pm.queryIntentActivities(intent, 0);
        if (resInfo.isEmpty()) {
            return null;
        }
        return pm.getLaunchIntentForPackage(resInfo.get(0).activityInfo.packageName);
    }

    private static Intent getBrowserIntent(Context context) {
        return getLaunchableIntent(context,
                new Intent(Intent.ACTION_VIEW, Uri.parse("http:")));
    }

    private static Intent getDialerIntent() {
        return new Intent(Intent.ACTION_DIAL, null);
    }

    private static Intent getEmailIntent(Context context) {
        return getLaunchableIntent(context,
                new Intent(Intent.ACTION_VIEW, Uri.parse("mailto:")));
    }

    private static Intent getMessagesIntent(Context context) {
        return getLaunchableIntent(context,
                new Intent(Intent.ACTION_VIEW, Uri.parse("sms:")));
    }

    public static Intent getIntentByAction(Context context, int action){
        Intent intent = null;
        if (action == TouchscreenGestureConstants.ACTION_BROWSER){
            intent = getBrowserIntent(context);
        }else if (action == TouchscreenGestureConstants.ACTION_DIALER){
            intent = getDialerIntent();
        }else if (action == TouchscreenGestureConstants.ACTION_EMAIL){
            intent = getEmailIntent(context);
        }else if (action == TouchscreenGestureConstants.ACTION_MESSAGES){
            intent = getMessagesIntent(context);
        }
        return intent;
    }

    public static void triggerAction(Context context, int action) {
        Intent intent = getIntentByAction(context, action);
        if (intent == null){
            return;
        }
        KeyguardManager km = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);
        if (km.isKeyguardLocked()){
            intent = new Intent();
            intent.setClassName("org.blissroms.settings.asusparts", "org.blissroms.settings.asusparts.touch.TouchGestureSettingsActivity");
            intent.putExtra(TouchGestureActivity.ACTION_KEY, action);
        }
        startActivitySafely(context, intent);
    }

    public static void startActivitySafely(Context context, Intent intent) {
        if (intent == null){
            return;
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK
                | Intent.FLAG_ACTIVITY_SINGLE_TOP
                | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        try {
            UserHandle user = new UserHandle(UserHandle.USER_CURRENT);
            context.startActivityAsUser(intent, null, user);
        } catch (Exception e) {
            // Ignore
        }
    }
}
