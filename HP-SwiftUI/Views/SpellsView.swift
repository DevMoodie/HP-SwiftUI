//
//  SpellsView.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import SwiftUI

struct SpellsView: View {
    
    @ObservedObject var spellsVM: SpellsViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(spellsVM.spells.filter { $0.name.hasPrefix(searchText) || searchText == "" }, id: \.self) { spell in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                            RoundedRectangle(cornerRadius: 15.0)
                                .foregroundColor(.white)
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("\(spell.name)")
                                        .font(.custom("New", size: 25.0))
                                    Spacer()
                                    Text("\(spell.description)")
                                        .font(.body.smallCaps())
                                }
                                Spacer()
                                Image(spell.isFavorites ? "yep" : "nope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .opacity(spell.isFavorites ? 1.0 : 0.3)
                                    .onTapGesture {
                                        
                                    }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        .shadow(radius: 10, y: 10)
                    }
                }
                .padding(.vertical)
            }
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    SpellsView(spellsVM: SpellsViewModel())
}
