import Flutter
import UIKit

let APP_GROUP_ID = "group.com.qantumapps.notifications"
let PENDING_NOTIFICATIONS_KEY = "pending_notifications"

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          }

    GeneratedPluginRegistrant.register(with: self)

    // ------------------------------------------------------------
    // Method channel: Flutter isko call karega startup pe pending
    // notifications padhne aur App Group se clear karne ke liye
    // ------------------------------------------------------------
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.qantum/native_notifications",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { (call, result) in
      if call.method == "getPendingNotifications" {
        guard let sharedDefaults = UserDefaults(suiteName: APP_GROUP_ID) else {
          result(FlutterError(code: "NO_APP_GROUP", message: "App Group access failed", details: nil))
          return
        }
        let pendingList = sharedDefaults.stringArray(forKey: PENDING_NOTIFICATIONS_KEY) ?? []

        // Padh liya, ab clear kar do taaki dobara migrate na ho
        sharedDefaults.removeObject(forKey: PENDING_NOTIFICATIONS_KEY)
        sharedDefaults.synchronize()

        print("[AppDelegate] getPendingNotifications -> \(pendingList.count) items, cleared from App Group")
        result(pendingList)
      } else if call.method == "setCurrentUserId" {
            guard let sharedDefaults = UserDefaults(suiteName: APP_GROUP_ID) else {
              result(FlutterError(code: "NO_APP_GROUP", message: "App Group access failed", details: nil))
              return
            }
            let args = call.arguments as? [String: Any]
            let userId = args?["userId"] as? String ?? "guest"
            sharedDefaults.set(userId, forKey: "current_user_id")
            sharedDefaults.synchronize()
            print("[AppDelegate] setCurrentUserId -> \(userId)")
            result(nil)

          }
     else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}