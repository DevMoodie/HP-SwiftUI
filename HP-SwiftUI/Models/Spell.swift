//
//  Spell.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

struct SpellAPI: Codable {
    let name: String
    let description: String
}

struct Spell: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    var isFavorites: Bool
    
    init(id: String, name: String, description: String, isFavorites: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.isFavorites = isFavorites
    }
}
