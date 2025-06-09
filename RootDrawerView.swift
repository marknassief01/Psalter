import SwiftUI

struct RootDrawerView: View {
    // Drawer state
    @State private var showSidebar = false
    @State private var dragOffset: CGFloat = 0
    private let drawerWidth: CGFloat = 260

    // Detail navigation
    @State private var currentScreen: DrawerScreen = .psalms

    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                
                // ── Detail area ──────────────────────────────
                Group {
                    switch currentScreen {
                    case .psalms:   ContentView()
                    case .settings: UnifiedSettingsView()
                    case .about:    AboutScreen()
                    case .help:     HelpScreen()
                    }
                }
                .disabled(showSidebar)
                .gesture(edgeSwipe)              // swipe-in
                
                // ── Drawer ─────────────────────────────────
                if showSidebar || dragOffset != 0 {
                    SidebarMenu(showSidebar: $showSidebar) { currentScreen = $0 }
                        .frame(width: drawerWidth)
                        .offset(x: showSidebar ? dragOffset
                                              : -drawerWidth + dragOffset)
                        .gesture(drawerSwipe)   // swipe-out
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }
            }
            // Floating chevron that tracks drawer
            /* ── Floating chevron that tracks drawer ──
            .overlay(
                Button {
                    withAnimation { showSidebar.toggle() }
                } label: {
                    Image(systemName: showSidebar ? "chevron.left" : "chevron.right")
                        .imageScale(.large)
                        .padding(12)
                        .background(.regularMaterial)
                        .clipShape(Circle())
                }
                // Stays at absolute top-left, above nav-bar
                .position(x: 28, y: 28)       // 28 = 12 pt padding + 16 pt radius
                .zIndex(3)                    // always above everything
            )
            */
            .animation(.spring(), value: showSidebar)
            .animation(.linear,  value: dragOffset)
            .navigationBarHidden(showSidebar)
        }
    }

    // MARK: – Gestures
    private var edgeSwipe: some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { if $0.translation.width > 80 { withAnimation { showSidebar = true } } }
    }
    private var drawerSwipe: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width < 0 { dragOffset = value.translation.width }
            }
            .onEnded { value in
                if value.translation.width < -80 { withAnimation { showSidebar = false } }
                dragOffset = 0
            }
    }
}

// Detail targets
enum DrawerScreen { case psalms, settings, about, help }

// Drawer menu without “Psalms” row
struct SidebarMenu: View {
    @Binding var showSidebar: Bool
    let select: (DrawerScreen) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Button("🏠 Home")     { select(.psalms);   showSidebar = false }
            Button("⚙️ Settings") { select(.settings); showSidebar = false }
            Button("ℹ️ About")    { select(.about);    showSidebar = false }
            Button("💬 Help")     { select(.help);     showSidebar = false }
            Spacer()
        }
        .font(.headline)
        .padding(.top, 60)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

