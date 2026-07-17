import UserNotifications
import OneSignalExtension


let APP_GROUP_ID = "group.com.qantumapps.notifications"
private let hostAppBundleId: String = {
    let extensionBundleId = Bundle.main.bundleIdentifier ?? "unknown"
    return extensionBundleId.replacingOccurrences(of: ".OneSignalNotificationServiceExtension", with: "")
}()

let PENDING_NOTIFICATIONS_KEY = "pending_notifications_\(hostAppBundleId)"

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var receivedRequest: UNNotificationRequest!
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.receivedRequest = request
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        OneSignalExtension.didReceiveNotificationExtensionRequest(
            self.receivedRequest,
            with: bestAttemptContent,
            withContentHandler: { [weak self] finalContent in
                self?.saveNotificationToAppGroup(request: request, processedContent: finalContent)
                contentHandler(finalContent)
            }
        )
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            OneSignalExtension.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
            saveNotificationToAppGroup(request: self.receivedRequest, processedContent: bestAttemptContent)
            contentHandler(bestAttemptContent)
        }
    }

    private func saveNotificationToAppGroup(request: UNNotificationRequest, processedContent: UNNotificationContent) {
        guard let sharedDefaults = UserDefaults(suiteName: APP_GROUP_ID) else {
            print("[NSE] ERROR: App Group '\(APP_GROUP_ID)' access nahi ho paaya")
            return
        }

        let userInfo = processedContent.userInfo
        let notificationId = request.identifier
        let currentUserId = sharedDefaults.string(forKey: "current_user_id_\(hostAppBundleId)") ?? "guest"

        print("[NSE] userInfo: \(userInfo)")

        var imageUrl: String? = nil
        if let att = userInfo["att"] as? [String: String] {
            imageUrl = att.values.first
        }

        var additionalDataJson: String = "{}"
        if let customData = userInfo["custom"] as? [String: Any],
           let additionalData = customData["a"] {
            if let jsonData = try? JSONSerialization.data(withJSONObject: additionalData, options: []),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                additionalDataJson = jsonString
            }
        }

        let notificationDict: [String: Any] = [
            "id": notificationId,
            "userId": currentUserId,
            "title": processedContent.title,
            "body": processedContent.body,
            "imageUrl": imageUrl ?? "",
            "payload": additionalDataJson,
            "receivedAt": ISO8601DateFormatter().string(from: Date())
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: notificationDict, options: []),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("[NSE] ERROR: notification data ko JSON me convert nahi kar paaya")
            return
        }

        var pendingList: [String] = sharedDefaults.stringArray(forKey: PENDING_NOTIFICATIONS_KEY) ?? []
        pendingList.append(jsonString)
        sharedDefaults.set(pendingList, forKey: PENDING_NOTIFICATIONS_KEY)
        sharedDefaults.synchronize()

        print("[NSE] SAVED to App Group: id=\(notificationId), title=\(processedContent.title), pending count=\(pendingList.count)")
    }
}