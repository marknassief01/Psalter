//
//  Bundle+Decode.swift
//  OrthodoxPsalter
//
//  Created by Mark Nassief on 6/4/25.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("❌ Could not find \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("❌ Could not load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("❌ Could not decode \(file).")
        }

        return loaded
    }
}
