import SwiftUI

/// Hides the default back button and puts a custom one on the top-right.
struct BackOnTrailing: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
    }
}
extension View {
    func backOnTrailing() -> some View { modifier(BackOnTrailing()) }
}
