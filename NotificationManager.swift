import UserNotifications

enum NotificationManager {
    
    /// Call once at first launch or when the user flips a toggle.
    static func requestAuthIfNeeded() async {
        let center  = UNUserNotificationCenter.current()
        
        // 1. Remove “try?” here – just await the settings
        let status  = await center.notificationSettings()
        
        // 2. Request permission only if we have not asked before
        if status.authorizationStatus == .notDetermined {
            // `requestAuthorization` *is* throwing, so keep `try?`
            _ = try? await center.requestAuthorization(options: [.alert, .sound])
        }
    }
    
    /// Clears every pending Psalter reminder.
    static func clearAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /// Schedules one daily psalm reminder at `hour` local time.
    static func scheduleDaily(hour: Int) {
        var date = DateComponents()
        date.hour = hour
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let content = UNMutableNotificationContent()
        content.title  = "Time to read a Psalm"
        content.body   = "Open the Psalter app to pray today’s psalm."
        content.sound  = .default
        let req = UNNotificationRequest(
            identifier: "dailyPsalter",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(req)
    }
    
    /// Schedules a repeating hourly reminder on the next top-of-the-hour.
    static func scheduleHourly() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600,
                                                        repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "Hourly Psalm Reminder"
        content.body  = "Pause a moment and read a psalm."
        content.sound = .default
        let req = UNNotificationRequest(
            identifier: "hourlyPsalter",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(req)
    }
}
