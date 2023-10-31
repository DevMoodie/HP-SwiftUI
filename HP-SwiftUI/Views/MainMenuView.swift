//
//  MainMenuView.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject var charactersVM: CharactersViewModel = CharactersViewModel()
    @StateObject var spellsVM: SpellsViewModel = SpellsViewModel()
    
    @State var spellsSelected: Bool = false
    
    var body: some View {
        VStack (alignment: .center) {
            HStack {
                Text(spellsSelected ? "Spells" : "Characters")
                    .font(.custom("New", size: 45.0).bold())
                    .opacity(1.0)
                    .padding(.trailing)
                Text(spellsSelected ? "Characters" : "Spells")
                    .font(.custom("New", size: 20.0))
                    .opacity(0.5)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(duration: 0.5, blendDuration: 1.3)) {
                            spellsSelected.toggle()
                        }
                    }
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.top)
            .padding(.bottom, -15)
            if spellsSelected {
                SpellsView(spellsVM: spellsVM)
                    .padding(.top, -15)
            } else {
                CharactersView(charactersVM: charactersVM)
            }
        }
    }
}

#Preview {
    MainMenuView()
}
#imageLiteral(resourceName: "simulator_screenshot_97C77EDE-237B-4FDB-A2C1-8071B5AADD80.png")
