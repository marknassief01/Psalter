//
//  Prayer.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/7/25.
//

import Foundation

struct Prayer: Identifiable, Codable {
    let id: Int
    let title: String
    let text: String
    let categoryIDs: [Int]
}
