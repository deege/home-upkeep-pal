import Foundation
#if canImport(UserNotifications)
import UserNotifications
#endif

/// Schedules local notifications for due tasks. This implementation is minimal and suitable for unit testing.
public final class NotificationScheduler {
    public init() {}

    /// Request notification authorization politely.
    public func requestAuthorization() {
        #if canImport(UserNotifications)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        #endif
    }

    /// Schedule a daily summary notification at the provided date components.
    public func scheduleDailySummary(at components: DateComponents) {
        #if canImport(UserNotifications)
        let content = UNMutableNotificationContent()
        content.title = "HomeCare Summary"
        content.body = "You have tasks due soon."
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "daily-summary", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        #endif
    }
}
