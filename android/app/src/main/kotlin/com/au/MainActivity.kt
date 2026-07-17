package com.au

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "com.qantum/native_notifications"

    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            val prefs = applicationContext.getSharedPreferences(
                NotificationServiceExtension.PREFS_NAME,
                MODE_PRIVATE
            )

            when (call.method) {
                "getPendingNotifications" -> {
                    val existingJson = prefs.getString(NotificationServiceExtension.PENDING_KEY, "[]") ?: "[]"
                    val existingArray = JSONArray(existingJson)
                    val pendingList = mutableListOf<String>()
                    for (i in 0 until existingArray.length()) {
                        pendingList.add(existingArray.getString(i))
                    }

                    // Padh liya, ab clear kar do taaki dobara migrate na ho
                    prefs.edit()
                        .putString(NotificationServiceExtension.PENDING_KEY, "[]")
                        .apply()

                    android.util.Log.d("MainActivity", "getPendingNotifications -> ${pendingList.size} items, cleared")
                    result.success(pendingList)
                }

                "setCurrentUserId" -> {
                    val userId = call.argument<String>("userId") ?: "guest"
                    prefs.edit()
                        .putString(NotificationServiceExtension.CURRENT_USER_KEY, userId)
                        .apply()

                    android.util.Log.d("MainActivity", "setCurrentUserId -> $userId")
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }
}