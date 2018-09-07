# This is a configuration file for ProGuard.
# http://proguard.sourceforge.net/index.html#manual/usage.html
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-verbose
-dontpreverify

# Optimize all the things (other than those listed)
-optimizations !field/*,!method/removal/parameter

-allowaccessmodification
-repackageclasses ''

# Note that you cannot just include these flags in your own
# configuration file; if you are including this file, optimization
# will be turned off. You'll need to either edit this file, or
# duplicate the contents of this file and remove the include of this
# file from your project's proguard.config path property.

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgent
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.app.Fragment
-keep public class * extends android.app.Fragment
-keep public class com.android.vending.licensing.ILicensingService

# For native methods, see http://proguard.sourceforge.net/manual/examples.html#native
-keepclasseswithmembernames class * {
    native <methods>;
}

-keep public class * extends android.view.View {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

# For enumeration classes, see http://proguard.sourceforge.net/manual/examples.html#enumerations
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

-keepclassmembers class **.R$* {
    public static <fields>;
}

# The support library contains references to newer platform versions.
# Don't warn about those in case this app is linking against an older
# platform version.  We know about them, and they are safe.
-dontwarn android.support.**

-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*
-renamesourcefileattribute SourceFile

# Dagger
-dontwarn com.google.errorprone.annotations.*

# Retrofit
-dontnote retrofit2.Platform
-dontwarn retrofit2.Platform$Java8
-keepattributes Signature
-keepattributes Exceptions

# Okhttp + Okio
-dontwarn okhttp3.**
-dontwarn okio.**
# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**
# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# GSON
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep Trakt-java Entity names (for GSON)
-keepclassmembers class com.uwetrottmann.trakt5.enums.** { *; }
-keepclassmembers class com.uwetrottmann.trakt5.entities.** { *; }

# Keep TMDb Entity names (for GSON)
-keepclassmembers class com.uwetrottmann.tmdb2.enumerations.** { *; }
-keepclassmembers class com.uwetrottmann.tmdb2.entities.** { *; }

# Keep stuff for Room
-keepclassmembers class * {
    @android.arch.persistence.room.TypeConverter <methods>;
}
-keepclassmembers class app.tivi.data.entities.** { *; }

# Glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

# Coroutines
-keepclassmembernames class kotlinx.** {
    volatile <fields>;
}
# Kotlin Metadata
-keep class kotlin.Metadata { *; }
# kotlin-reflect
-keep public class kotlin.reflect.jvm.internal.impl.builtins.* { public *; }

# BaseMvRxViewModels loads the Companion class via reflection and thus we need to make sure we keep
# the name of the Companion object.
-keepclassmembers class ** extends com.airbnb.mvrx.BaseMvRxViewModel {
    ** Companion;
}

# Classes extending BaseMvRxViewModel are recreated using reflection, which assumes that a one argument
# constructor accepting a data class holding the state exists. Need to make sure to keep the constructor
# around. Additionally, a static create method will be generated in the case a companion object factory
# is used. This is accessed via reflection.
-keepclassmembers class ** extends com.airbnb.mvrx.BaseMvRxViewModel {
    public <init>(...);
    public static *** create(...);
}

# Stop R8 converting these classes to abstract
-keep class * implements com.airbnb.mvrx.MvRxState { *; }
# Keep the marker interface
-keep class com.airbnb.mvrx.MvRxState

# Retrofit does reflection on generic parameters and InnerClass is required to use Signature.
-keepattributes Signature, InnerClasses

# Retain service method parameters when optimizing.
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}