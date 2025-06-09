/*
import SwiftUI

struct MainSidebarView: View {
    @State private var selection: String? = "psalms"

    var body: some View {
        NavigationSplitView {
            // ── Sidebar ───────────────────────────────
            List(selection: $selection) {
                NavigationLink(value: "psalms") { Label("Psalms",   systemImage: "book") }
                NavigationLink(value: "settings") { Label("Settings", systemImage: "gearshape") }
                NavigationLink(value: "about")    { Label("About",    systemImage: "info.circle") }
                NavigationLink(value: "help")     { Label("Help",     systemImage: "questionmark.circle") }
            }
            .navigationTitle("Menu")
        } detail: {
            // ── Detail ────────────────────────────────
            switch selection {
            case "psalms":
                ContentView()                    // shows categories + Psalms / Prayers
            case "settings":
                UnifiedSettingsView()            // NEW unified settings
            case "about":
                AboutScreen()
            case "help":
                HelpScreen()
            default:
                Text("Select a section")
            }
        }
    }
}
*/
