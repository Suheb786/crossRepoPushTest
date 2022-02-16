-keep class androidx.lifecycle.DefaultLifecycleObserver
-keep class androidx.lifecycle.** { *; }
-keep class androidx.appcompat.** { *; }
-keep class com.microblink.** { *; }
# Application classes that will be serialized/deserialized over Gson
# Infobip Messaging Plugin Configuration Class
-keep class org.infobip.plugins.mobilemessaging.flutter.common.Configuration* { *; }