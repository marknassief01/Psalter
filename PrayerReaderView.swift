//
//  PrayerReaderView.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/8/25.
//

import SwiftUI

struct PrayerReaderView: View {
    let prayer: Prayer

    var body: some View {
        ScrollView {
            Text(prayer.text)
                .padding()
                .navigationTitle(prayer.title)
                .backOnTrailing()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
