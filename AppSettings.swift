
//  AppSettings.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/4/25.
//

import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("fontFamily") var fontFamily: String = "System"
    @AppStorage("lineSpacing") var lineSpacing: Double = 1.4
    @AppStorage("textAlignment") var textAlignment: String = "Left"
    @AppStorage("readingMode") var readingMode: String = "scroll"

    @AppStorage("theme") var theme: String = "system"
    @AppStorage("texture") var texture: String = "Plain"
    @AppStorage("accentColor") var accentColor: String = "System Blue"

    @AppStorage("showVerseNumbers") var showVerseNumbers: Bool = true
    @AppStorage("verseSpacing") var verseSpacing: String = "medium"
    @AppStorage("fullScreen") var fullScreen: Bool = false

    @AppStorage("startAt") var startAt: String = "Psalm 1"
    //@AppStorage("prayerRule") var prayerRule: String = "None"
    @AppStorage("dailyReminder") private var dailyReminderRaw: Double = Date().timeIntervalSince1970
    var dailyReminder: Date {
        get { Date(timeIntervalSince1970: dailyReminderRaw) }
        set { dailyReminderRaw = newValue.timeIntervalSince1970 }
    }

    @AppStorage("autoHideUI") var autoHideUI: Bool = true
    @AppStorage("swipeNav") var swipeNav: Bool = true
    @AppStorage("haptics") var haptics: Bool = true
    
    @AppStorage("lastReadPsalmID") var lastReadPsalmID: Int?
}
