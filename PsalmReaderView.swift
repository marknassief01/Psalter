import SwiftUI

struct PsalmReaderView: View {
    let psalm: Psalm
    @StateObject private var settings = AppSettings()

    // Tabs
    @State private var selectedTab = "Psalm"
    private let tabs = ["Psalm", "Commentary"]

    // Commentary data
    @State private var allCommentaries: [Commentary] = []
    @State private var selectedCommentary: Commentary?

    // Drawer state (75 % of screen)
    private let drawerW = UIScreen.main.bounds.width * 0.75
    @State  private var drawerX: CGFloat = -UIScreen.main.bounds.width * 0.75
    @GestureState private var dragX: CGFloat = 0
    private var drawerOpen: Bool { drawerX == 0 }

    // Church-Father list
    struct Author: Hashable { let name, icon: String }
    private let authors: [Author] = [
        .init(name: "St. John Chrysostom",       icon: "chrysostom"),
        .init(name: "St. Augustine of Hippo",    icon: "augustine"),
        .init(name: "St. Basil the Great",       icon: "basil"),
        .init(name: "St. Jerome of Stridon",     icon: "jerome"),
        .init(name: "St. Hilary of Poitiers",    icon: "hilary"),
        .init(name: "Fr. Tadros Malaty",         icon: "tadros"),
        .init(name: "HH St. Pope Shenouda III",  icon: "shenouda")
    ]
    private var psalmCommentaries: [Commentary] {
        allCommentaries.filter { $0.id == psalm.id }
    }

    // ─────────── View ───────────
    var body: some View {
        ZStack(alignment: .leading) {
            // Main reader wrapped in NavigationStack
            NavigationStack {
                VStack(spacing: 0) {
                    // Tab picker
                    Picker("", selection: $selectedTab) {
                        ForEach(tabs, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    // Content
                    ZStack {
                        psalmScroll     .opacity(selectedTab == "Psalm"       ? 1 : 0)
                        commentaryGrid  .opacity(selectedTab == "Commentary" ? 1 : 0)
                    }
                }
                .navigationTitle(settings.fullScreen ? "" : psalm.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(drawerOpen)        // hide bar when drawer open
                .backOnTrailing()                       // your custom right-side back button
                .sheet(item: $selectedCommentary) { CommentarySheet(commentary: $0) }
                .onAppear {
                    if allCommentaries.isEmpty {
                        allCommentaries = Bundle.main.decode("commentaries.json")
                    }
                }
            }
            .disabled(drawerOpen)                       // block taps under drawer
            .gesture(edgeSwipe)                         // swipe-in gesture

            // Drawer layer
            DrawerMenu()
                .frame(width: drawerW)
                .offset(x: drawerX + dragX)
                .gesture(drawerSwipe)                   // swipe-out gesture
                .animation(.spring(), value: drawerX)
                .zIndex(1)                              // sits above nav bar
        }
    }

    // ─────────── Sub-views ───────────
    private var psalmScroll: some View {
        ScrollView { Text(psalm.text).padding() }
    }

    private var commentaryGrid: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(authors, id: \.self) { author in
                    Button {
                        selectedCommentary = psalmCommentaries.first { $0.author == author.name }
                    } label: {
                        VStack {
                            Image(author.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            Text(author.name)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
    }

    // ─────────── Gestures ───────────
    private var edgeSwipe: some Gesture {
        // Swipe right from far left edge to open
        DragGesture(minimumDistance: 20)
            .onEnded { if $0.translation.width > 80 { openDrawer() } }
    }

    private var drawerSwipe: some Gesture {
        // Drag left on drawer to close
        DragGesture()
            .updating($dragX) { val, state, _ in
                if val.translation.width < 0 { state = val.translation.width }
            }
            .onEnded { if $0.translation.width < -80 { closeDrawer() } }
    }

    // Drawer helpers
    private func openDrawer()  { drawerX = 0 }
    private func closeDrawer() { drawerX = -drawerW }
}

// ─────────── Drawer Menu ───────────
private struct DrawerMenu: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            NavigationLink("Settings") { UnifiedSettingsView() }
            NavigationLink("About")    { AboutScreen() }
            NavigationLink("Help")     { HelpScreen() }
            Spacer()
        }
        .font(.headline)
        .padding(.top, 60)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

// ─────────── Commentary Sheet ───────────
private struct CommentarySheet: View {
    let commentary: Commentary
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(commentary.author).font(.title2).bold()
                Text(commentary.text)
            }
            .padding()
        }
    }
}
