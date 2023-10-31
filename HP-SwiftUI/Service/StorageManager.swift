//
//  StorageManager.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

// Switch this over to SwiftData
final class StorageManager: StorageManagerProtocol {
    private var defaults: UserDefaults
    private let favoritesKey = "favoritesSpells"
    private(set) var favoritesSpells: [String] = []

    init (userDefaults: UserDefaults = UserDefaults.standard) {
        defaults = userDefaults
    }

    func save(spell: String) {
        favoritesSpells.append(spell)
        defaults.set(favoritesSpells, forKey: favoritesKey)
    }

    func fetch() -> [String] {
        if let favorites = defaults.value(forKey: favoritesKey) as? [String] {
            favoritesSpells = favorites
            return favorites
        }
        return []
    }

    func remove(spell: String) {
        favoritesSpells = favoritesSpells.filter { $0 != spell }
        defaults.set(favoritesSpells, forKey: favoritesKey)
    }
}
