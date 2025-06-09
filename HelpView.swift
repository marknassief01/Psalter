import SwiftUI
import MessageUI

struct HelpScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Suggestions & Help")
                    .font(.title)
                    .bold()

                Text("""
Need help? Have feedback or feature suggestions? We're always listening.
""")

                Link("📧 Email Support", destination: URL(string: "mailto:severus.dioscorus.kyrillos@gmail.com")!)
                    .font(.headline)
                    .foregroundColor(.blue)

                Text("""
Please include the issue you encountered, your iOS version, and any screenshots if possible. We’ll try to get back to you quickly.
""")

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Help")
        .backOnTrailing()
    }
}
