//
//  Psalm.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/4/25.
//

import Foundation

struct Psalm: Identifiable, Codable {
    let id: Int
    let title: String
    let text: String
    let categoryIDs: [Int]
}
