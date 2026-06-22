#if os(iOS)
import AVFoundation
import BackgroundTasks
import Combine
import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private let reciterDownloadsSessionID = AppIdentifiers.reciterDownloadsBackgroundSessionIdentifier

    // Connects iOS background URL session wakeups to the reciter download manager.
    func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void
    ) {
        guard identifier == reciterDownloadsSessionID else {
            completionHandler()
            return
        }

        ReciterDownloadManager.shared.backgroundSessionCompletionHandler(completionHandler)
    }

    // Shows in-app notifications as banner + sound when a notification arrives in foreground, and keeps
    // them in Notification Center (.list) so a missed banner isn't lost.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .list, .sound])
    }
}
#endif
