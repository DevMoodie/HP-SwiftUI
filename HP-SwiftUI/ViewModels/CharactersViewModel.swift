//
//  CharactersViewModel.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

@MainActor
class CharactersViewModel: ObservableObject {
    @Published var characters: [HPCharacter] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private let networkManager: NetworkingManagerProtocol = NetworkManager()
    private var retryFetchImage = 0
    
    init() {
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        retryFetchImage += 1
        
        Task {
            do {
                self.characters = try await networkManager.getCharacters()
            } catch {
                // Show an Alert
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
