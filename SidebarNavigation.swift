// SidebarNavigation.swift

import SwiftUI

struct SidebarView: View {
    @AppStorage("selectedSidebarTab") private var selectedSidebarTab: String = "Settings"

    var body: some View {
        NavigationView {
            List {
                SidebarButton(label: "Settings", systemIcon: "gearshape") {
                    selectedSidebarTab = "Settings"
                }
                SidebarButton(label: "About", systemIcon: "info.circle") {
                    selectedSidebarTab = "About"
                }
                SidebarButton(label: "Suggestion / Help", systemIcon: "questionmark.circle") {
                    selectedSidebarTab = "Help"
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Menu")
            .backOnTrailing()

            SidebarContentView(selectedTab: selectedSidebarTab)
        }
    }
}

struct SidebarButton: View {
    let label: String
    let systemIcon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(label, systemImage: systemIcon)
        }
    }
}

struct SidebarContentView: View {
    let selectedTab: String

    var body: some View {
        switch selectedTab {
        case "Settings":
            AppSettingsView()
        case "About":
            AboutView()
        case "Help":
            HelpView()
        default:
            Text("Select a section")
        }
    }
}

// Placeholder views
struct AppSettingsView: View {
    var body: some View {
        VStack {
            Text("App Settings")
            // Add appearance/theme toggle, reminders, spiritual settings
        }
        .padding()
    }
}

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("About Orthodox Psalter")
                .font(.title2).bold()
            Text("Version 1.0")
            Text("Developed with love.")
        }
        .padding()
    }
}

struct HelpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Need help?").font(.title2).bold()
            Text("For suggestions or support, contact support@example.com")
        }
        .padding()
    }
}
