//
//  ContentView.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/4/25.
//

import SwiftUI

struct ContentView: View {
    let categories: [PsalmCategory] = Bundle.main.decode("categories.json")
   
    let prayers: [Prayer] = Bundle.main.decode("prayers.json")
    
    @StateObject private var settings = AppSettings()
    let psalms: [Psalm] = Bundle.main.decode("psalms.json")
    
    var body: some View {
        NavigationStack {
            VStack {
                if let id = settings.lastReadPsalmID,
                   let savedPsalm = psalms.first(where: { $0.id == id }) {
                    NavigationLink("📖 Resume Last Psalm (\(savedPsalm.title))") {
                        PsalmReaderView(psalm: savedPsalm)
                    }
                    .padding(.bottom)
                }

                List(categories) { category in
                    NavigationLink(category.name) {
                        PsalmListView(category: category)
                    }
                }
            }
            .navigationTitle("Psalter")
            .backOnTrailing()
        }
    }
}
