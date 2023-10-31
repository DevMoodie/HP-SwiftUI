//
//  NetworkManager.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

enum Link: String {
    case characters = "https://hp-api.onrender.com/api/characters"
    case spells = "https://hp-api.onrender.com/api/spells"
}

enum APIError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet
    
    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}

class NetworkManager: NetworkingManagerProtocol {
    
    func getCharacters() async throws -> [HPCharacter] {
        guard let url = URL(string: Link.characters.rawValue) else {
            throw APIError.requestFailed(description: "Characters URL Fetch Went Wrong!")
        }
        
        do {
            let characters = try await fetch(type: [HPCharacter].self, with: URLRequest(url: url))
            return characters
        } catch {
            throw APIError.requestFailed(description: "\((error as! APIError).customDescription)")
        }
    }
    
    func getSpells() async throws -> [Spell] {
        guard let url = URL(string: Link.spells.rawValue) else {
            throw APIError.requestFailed(description: "Spells URL Fetch Went Wrong!")
        }
        
        do {
            let spellsTemp = try await fetch(type: [SpellAPI].self, with: URLRequest(url: url))
            let spells = spellsTemp.map { spell in
                Spell(
                    id: "\(spell.name)" + "\(spell.description.prefix(3))",
                    name: spell.name,
                    description: spell.description,
                    isFavorites: false
                )
            }
            return spells
        } catch {
            throw APIError.requestFailed(description: "\((error as! APIError).customDescription)")
        }
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        guard let imageDate = try? Data(contentsOf: url) else {
            throw APIError.invalidData
        }
        
        return imageDate
    }
    
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}



