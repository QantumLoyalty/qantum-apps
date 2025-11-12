# --- Stripe SDK keep rules ---
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# --- Flutter Stripe wrapper (if used) ---
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

# --- Google Pay / Push Provisioning (avoid missing class errors) ---
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
-dontwarn kotlinx.parcelize.Parceler$DefaultImpls
-dontwarn kotlinx.parcelize.Parceler
-dontwarn kotlinx.parcelize.Parcelize
# Keep Stripe classes
-keep class com.stripe.** { *; }
