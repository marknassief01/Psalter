import SwiftUI

/// Combined App-wide + Reader settings screen.
/// • Text, Appearance, Layout, Spiritual, Experience sections
/// • Reminder switches call NotificationManager
struct UnifiedSettingsView: View {

    // MARK: – Persisted values
    @AppStorage("fontSize")         private var fontSize: Double = 18
    @AppStorage("fontFamily")       private var fontFamily      = "System"
    @AppStorage("lineSpacing")      private var lineSpacing     = 1.4
    @AppStorage("textAlignment")    private var textAlignment   = "Left"

    @AppStorage("texture")          private var texture         = "Plain"
    @AppStorage("accentColor")      private var accentColor     = "System Blue"

    @AppStorage("showVerseNumbers") private var showVerseNumbers = true
    @AppStorage("verseSpacing")     private var verseSpacing     = "medium"
    @AppStorage("fullScreen")       private var fullScreen       = false

    @AppStorage("startAt")          private var startAt          = "Psalm 1"
    @AppStorage("dailyEnabled")     private var dailyEnabled     = false
    @AppStorage("dailyHour")        private var dailyHour        = 9
    @AppStorage("hourlyEnabled")    private var hourlyEnabled    = false

    @AppStorage("autoHideUI")       private var autoHideUI       = true
    @AppStorage("swipeNav")         private var swipeNav         = true
    @AppStorage("haptics")          private var haptics          = true

    // MARK: – Static option lists
    private let fontFamilies = ["System","Georgia","Palatino","New York","San Francisco Serif"]
    private let alignments   = ["Left","Justified","Center"]
    private let textures     = ["Plain","Parchment","Paper Grain"]
    private let accentColors = ["System Blue","Liturgical Red","Byzantine Gold","Monastic Gray"]
    private let startOptions = ["Psalm 1","Psalm 50","Last Read"]

    var body: some View {
        Form {

            // ── Text ─────────────────────────────────────────────
            Section("Text") {
                Stepper(value: $fontSize, in: 12...30) {
                    Text("Font Size: \(Int(fontSize)) pt")
                }
                Picker("Font Family", selection: $fontFamily) {
                    ForEach(fontFamilies, id: \.self) { Text($0) }
                }
                Slider(value: $lineSpacing, in: 1...2, step: 0.1) {
                    Text("Line Spacing")
                }
                Picker("Alignment", selection: $textAlignment) {
                    ForEach(alignments, id: \.self) { Text($0) }
                }
            }

            // ── Appearance (no global theme switch) ─────────────
            Section("Appearance") {
                Picker("Background Texture", selection: $texture) {
                    ForEach(textures, id: \.self) { Text($0) }
                }
                Picker("Accent Colour", selection: $accentColor) {
                    ForEach(accentColors, id: \.self) { Text($0) }
                }
            }

            // ── Layout ──────────────────────────────────────────
            Section("Layout") {
                Toggle("Show Verse Numbers", isOn: $showVerseNumbers)
                Picker("Verse Spacing", selection: $verseSpacing) {
                    Text("Small").tag("small")
                    Text("Medium").tag("medium")
                    Text("Large").tag("large")
                }
                .pickerStyle(.segmented)
                Toggle("Full-Screen Reading", isOn: $fullScreen)
            }

            // ── Spiritual Reminders ─────────────────────────────
            Section("Spiritual") {
                Picker("Start Reading At", selection: $startAt) {
                    ForEach(startOptions, id: \.self) { Text($0) }
                }
                Toggle("Daily Reminder", isOn: $dailyEnabled)
                if dailyEnabled {
                    DatePicker(
                        "Hour",
                        selection: Binding(get: {
                            Calendar.current.date(
                                bySettingHour: dailyHour,
                                minute: 0,
                                second: 0,
                                of: .now) ?? .now
                        }, set: { newDate in
                            dailyHour = Calendar.current.component(.hour, from: newDate)
                        }),
                        displayedComponents: .hourAndMinute
                    )
                }
                Toggle("Hourly Reminder", isOn: $hourlyEnabled)
            }
            .onChange(of: dailyEnabled)  { scheduleNotifications() }
            .onChange(of: hourlyEnabled) { scheduleNotifications() }
            .onChange(of: dailyHour)     { scheduleNotifications() }

            // ── Experience ──────────────────────────────────────
            Section("Experience") {
                Toggle("Hide UI on Scroll", isOn: $autoHideUI)
                Toggle("Swipe Navigation",  isOn: $swipeNav)
                Toggle("Haptic Feedback",   isOn: $haptics)
            }
        }
        .navigationTitle("Settings")
        .backOnTrailing()
        .onAppear { scheduleNotifications() }
    }

    // MARK: – Notifications
    private func scheduleNotifications() {
        Task {
            await NotificationManager.requestAuthIfNeeded()
            NotificationManager.clearAll()
            if dailyEnabled  { NotificationManager.scheduleDaily(hour: dailyHour) }
            if hourlyEnabled { NotificationManager.scheduleHourly()               }
        }
    }
}
