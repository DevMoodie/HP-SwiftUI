//
//  StorageManagerProtocol.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

protocol StorageManagerProtocol: AnyObject {
    func save(spell: String)
    func fetch() -> [String]
    func remove(spell: String)
}
