//
//  Commentary.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/8/25.
//

import Foundation

struct Commentary: Identifiable, Codable {
    let id: Int               // same as Psalm ID
    let author: String        // e.g., "St. John Chrysostom"
    let text: String
}
