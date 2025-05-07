# Keep all ML Kit text recognition classes (to avoid missing classes error)
-keep class com.google.mlkit.** { *; }
-keep class org.tensorflow.** { *; }
-dontwarn com.google.mlkit.**
-dontwarn org.tensorflow.**
