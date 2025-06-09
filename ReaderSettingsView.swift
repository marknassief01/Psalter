/*import SwiftUI

struct ReaderSettingsView: View {
    @StateObject private var settings = AppSettings()

    private let fontFamilies   = ["System", "Georgia", "Palatino", "New York", "San Francisco Serif"]
    private let alignments     = ["Left", "Justified", "Center"]

    var body: some View {
        Form {
            Section("Text") {
                Slider(value: $settings.fontSize, in: 12...30, step: 1) { Text("Font Size") }
                Picker("Font", selection: $settings.fontFamily) {
                    ForEach(fontFamilies, id: \.self) { Text($0) }
                }
                Slider(value: $settings.lineSpacing, in: 1...2, step: 0.1) { Text("Line Spacing") }
                Picker("Alignment", selection: $settings.textAlignment) {
                    ForEach(alignments, id: \.self) { Text($0) }
                }
            }
            .navigationTitle("Reader Settings")
        }
    }
}
*/
