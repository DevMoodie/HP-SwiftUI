//
//  CharactersView.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersView: View {
    
    @ObservedObject var charactersVM: CharactersViewModel
    
    @State var selectedCharacter: HPCharacter?
    
    var body: some View {
        VStack (alignment: .leading) {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(charactersVM.characters, id: \.self) { character in
                        if character.image != "" {
                            let imageURL = URL(string: character.image)
                            
                            WebImage(url: imageURL)
                                .resizable()
                                .placeholder {
                                    ZStack {
                                        Color.black
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: 300, height: 450)
                                .cornerRadius(15.0)
                                .shadow(radius: 10, y: 10)
                                .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .horizontal) { effect, phase in
                                    effect
                                        .scaleEffect(1 - abs(phase.value / 3))
                                        .opacity(1 - abs(phase.value / 2))
                                        .rotation3DEffect(.degrees(phase.value * -25),
                                                          axis: (x: 0, y: 1, z: 0))
                                        .offset(x: -50 * abs(phase.value))
                                }
                                .onAppear {
                                    if selectedCharacter == nil {
                                        guard let firstCharacter = charactersVM.characters.first else { return }
                                        self.selectedCharacter = firstCharacter
                                    }
                                }
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, 20)
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selectedCharacter)
            VStack (alignment: .leading) {
                Text("\(selectedCharacter?.name == "" ? "-" : selectedCharacter?.name ?? "")")
                    .font(.custom("HarryP", size: 45.0))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                Text("House: \(selectedCharacter?.house == "" ? "-" : selectedCharacter?.house ?? "")")
                    .font(.custom("New", size: 20.0))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                Text("Wand: \(selectedCharacter?.wand.wood == "" ? "-" : selectedCharacter?.wand.wood ?? "")")
                    .font(.custom("New", size: 20.0))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                Text("Actor: \(selectedCharacter?.actor == "" ? "-" : selectedCharacter?.actor ?? "")")
                    .font(.custom("New", size: 20.0))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
            }
            .padding(20)
            Spacer()
        }
    }
}
