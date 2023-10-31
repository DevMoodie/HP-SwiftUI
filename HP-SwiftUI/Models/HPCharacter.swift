//
//  Character.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

struct HPCharacter: Codable, Equatable, Hashable {
    let name: String
    let house: String
    let wand: Wand
    let image: String
    let actor: String
    
    static func ==(lhs: HPCharacter, rhs: HPCharacter) -> Bool {
        return lhs.name == rhs.name &&
               lhs.house == rhs.house &&
               lhs.wand == rhs.wand &&
               lhs.image == rhs.image &&
               lhs.actor == rhs.actor
    }
}
