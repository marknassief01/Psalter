//
//  CommentaryView.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/8/25.
//

import SwiftUI

struct CommentaryView: View {
    let commentary: Commentary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(commentary.author)
                    .font(.title2)
                    .bold()
                Text(commentary.text)
                    .font(.body)
            }
            .padding()
        }
    }
}
