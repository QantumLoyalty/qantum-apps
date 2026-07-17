// ============================================================================
// Ye file android/app/src/main/kotlin/<your/package/path>/NotificationServiceExtension.kt
// me banani hai - EXACT package name apne AndroidManifest.xml ke "package"
// attribute se match karna, pehli line me
// ============================================================================

package com.au

import android.content.Context
import androidx.annotation.Keep
import com.onesignal.notifications.INotificationReceivedEvent
import com.onesignal.notifications.INotificationServiceExtension
import org.json.JSONArray
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone

// @Keep is REQUIRED - ProGuard/R8 minification isko rename/remove kar sakta
// hai warna, aur phir OneSignal runtime pe isko dhundh nahi paayega
@Keep
class NotificationServiceExtension : INotificationServiceExtension {

    companion object {
        const val PREFS_NAME = "native_notifications_prefs"
        const val PENDING_KEY = "pending_notifications"
        const val CURRENT_USER_KEY = "current_user_id"
    }

    override fun onNotificationReceived(event: INotificationReceivedEvent) {
        val notification = event.notification
        val context = event.context

        try {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

            val currentUserId = prefs.getString(CURRENT_USER_KEY, "guest") ?: "guest"

            val notificationId = notification.notificationId ?: ""
            val title = notification.title ?: ""
            val body = notification.body ?: ""
            val imageUrl = notification.bigPicture ?: notification.largeIcon ?: ""

            val additionalDataJson: String =
                notification.additionalData?.toString() ?: "{}"

            val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.US)
            sdf.timeZone = TimeZone.getTimeZone("UTC")
            val receivedAt = sdf.format(Date())

            val notificationObj = JSONObject().apply {
                put("id", notificationId)
                put("userId", currentUserId)
                put("title", title)
                put("body", body)
                put("imageUrl", imageUrl)
                put("payload", additionalDataJson)
                put("receivedAt", receivedAt)
            }

            // Existing pending list padho, naya entry append karo, wapas save karo
            val existingJson = prefs.getString(PENDING_KEY, "[]") ?: "[]"
            val existingArray = JSONArray(existingJson)
            val newArray = JSONArray()
            for (i in 0 until existingArray.length()) {
                newArray.put(existingArray.getString(i))
            }
            newArray.put(notificationObj.toString())

            prefs.edit()
                .putString(PENDING_KEY, newArray.toString())
                .apply()

            android.util.Log.d(
                "NSE",
                "SAVED: id=$notificationId, title=$title, pending count=${newArray.length()}"
            )
        } catch (e: Exception) {
            android.util.Log.e("NSE", "Error saving notification: ${e.message}")
        }

        // Notification ko normally display hone do (default behaviour override nahi kar rahe)
    }
}