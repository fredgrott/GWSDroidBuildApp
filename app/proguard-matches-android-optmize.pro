# Copyright (C) 2016 Fred Grott(aka shareme GrottWorkShop)
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under License.
#
#
# this file is to be paired with the proguard-android-optmize.txt in the sdk/tools/proguard
# location and is NOT meant to be used unpiared without that file



# OEMS with 4.x goofed up and included a common support lib in ROMS to
# avoid including with their default apps to save ROM space so to
# avoid the old android support lib conflictting with our newer one as
# its on the classpath via loader
# we rename the offending android support package
-repackageclasses 'android.support.v7'
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,EnclosingMethod,RuntimeVisibleAnnotations,AnnotationDefault

-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgent
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.app.Fragment
-keep public class * extends android.app.Fragment

-keepclasseswithmembers class * {
     public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class * {
     public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keepclassmembers class * {
   @com.google.api.client.util.Key <fields>;
}

# Needed just to be safe in terms of keeping Google API service model classes
-keep class com.google.api.services.*.model.*
-keep class com.google.api.client.**

# See https://groups.google.com/forum/#!topic/guava-discuss/YCZzeCiIVoI
-dontwarn com.google.common.collect.MinMaxPriorityQueue
# Assume dependency libraries Just Work(TM)
-dontwarn com.google.android.youtube.**
-dontwarn com.google.android.analytics.**
-dontwarn com.google.common.**
# Don't discard Guava classes that raise warnings
-keep class com.google.common.collect.MapMakerInternalMap$ReferenceEntry
-keep class com.google.common.cache.LocalCache$ReferenceEntry
# Make sure that Google Analytics doesn't get removed
-keep class com.google.analytics.tracking.android.CampaignTrackingReceiver

-keep class com.google.android.**
-keep class com.google.android.gms.**
-keep class com.google.android.gms.location.**
-keep class com.google.api.client.**
-keep class com.google.maps.android.**
-keep class libcore.**

-dontwarn com.google.common.cache.**
-dontwarn com.google.common.primitives.**
-dontwarn com.google.api.client.googleapis.**

-dontwarn sun.misc.Unsafe
-dontwarn com.google.common.util.concurrent.RateLimiter
-dontwarn javax.annotation.**

-keep class android.support.v8.renderscript.** { *; }
-keep public class * extends android.app,backup.BackupAgent
-keep class android.support.v4.app.** { *; }
-keep interface android.support.v4.app.** { *; }

-keep class !android.support.v7.internal.view.menu.*MenuBuilder*,android.support.v7.** { *; }
-keep interface android.support.v7.app.** { *; }

-keep class android.support.v13.app.** { *; }
-keep interface android.support.v13.app.** { *; }
-keep class android.support.design.widget.** { *; }
-keep interface android.support.design.widget.** { *;}

# Android Support Cardview-v7
# http://stackoverflow.com/questions/29679177/cardview-shadow-not-appearing-in-lollipop-after-obfuscate-with-proguard/29698051
-keep class android.support.v7.widget.RoundRectDrawable { *; }

# Android Support Design
-dontwarn android.support.design.**
-keep class android.support.design.** { *; }
-keep interface android.support.design.** { *; }
-keep public class android.support.design.R$* { *; }

# Android Support AppCompat-v7
-keep public class android.support.v7.widget.** { *; }
-keep public class android.support.v7.internal.widget.** { *; }
-keep public class android.support.v7.internal.view.menu.** { *; }

-keep public class * extends android.support.v4.view.ActionProvider {
    public <init>(android.content.Context);
}
