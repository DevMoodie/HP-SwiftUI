//
//  SpellsViewModel.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import Foundation

@MainActor
class SpellsViewModel: ObservableObject {
    @Published var spells: [Spell] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private let networkManager: NetworkingManagerProtocol = NetworkManager()
    
    init() {
        fetchSpells()
    }
    
    private func fetchSpells() {
        Task {
            do {
                self.spells = try await networkManager.getSpells()
                
                
            } catch {
                // Show an Alert
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
