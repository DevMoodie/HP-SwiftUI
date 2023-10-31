//
//  NetworkManagerProtocol.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

protocol NetworkingManagerProtocol: AnyObject {
    func getCharacters() async throws -> [HPCharacter]
    func getSpells() async throws -> [Spell]
    func fetchImage(from url: URL) async throws -> Data
}
