//
//  PsalmListView.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/4/25.
//

import SwiftUI

struct PsalmListView: View {
    let category: PsalmCategory
    let psalms: [Psalm] = Bundle.main.decode("psalms.json")
    let prayers: [Prayer] = Bundle.main.decode("prayers.json")
    
    var filteredPsalms: [Psalm] {
        psalms.filter { $0.categoryIDs.contains(category.id) }
    }
    
    var filteredPrayers: [Prayer] {
        prayers.filter { $0.categoryIDs.contains(category.id) }
    }


    @State private var selectedTab = "Psalms"
    let tabs = ["Psalms", "Prayers"]

    var body: some View {
        VStack {
            Picker("Tab", selection: $selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            if selectedTab == "Psalms" {
                List(filteredPsalms) { psalm in
                    NavigationLink(psalm.title) {
                        PsalmReaderView(psalm: psalm)
                    }
                }
            } else if selectedTab == "Prayers" {
                List(filteredPrayers) { prayer in
                    NavigationLink(prayer.title) {
                        PrayerReaderView(prayer: prayer)
                    }
                }
            }
            }
        .navigationTitle(category.name)
        .backOnTrailing()
        }
       

}
