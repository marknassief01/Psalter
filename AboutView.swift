import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About the Orthodox Psalter")
                    .font(.title)
                    .bold()

                Text("""
This app contains the full Book of Psalms according to the Septuagint, organized by spiritual themes such as Repentance, Thanksgiving, and more. Designed for prayer and meditation in the Oriental Orthodox tradition.
""")

                Text("""
All texts and commentaries are drawn from trusted patristic and liturgical sources. The app is a tool for personal devotion and theological reflection.
""")

                Text("Icons and design elements are chosen to reflect traditional Orthodox aesthetics.")

                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
        .backOnTrailing()
    }
}
