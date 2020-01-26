//
//  Deck.swift
//  dict
//
//  Created by Bartosz Zbislawski on 19/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @Binding var showSheet: Bool
    @Binding var activeSheet: ActiveSheet
    @Binding var activeDeck: Deck
    var deck: Deck
    
    var flashCards: [FlashCard] {
        return deck.flashCardArray
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(deck.wrappedName)
                    .padding(.leading, 20)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.lightGrayFont)
                Spacer()
            }.padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    HStack {
                        ForEach(self.flashCards, id: \.self) { flashCard in
                            ZStack {
                                Image("rectangle")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 160, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 5, x: 0, y: 4)
                                
                                Text(flashCard.wrappedWord)
                                    .bold()
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: 280)
                                    .shadow(radius: 10)
                            }
                            .padding(.top, 5)
                            .padding(.bottom)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            
                        }
                        Button(action: {
                            self.showSheet.toggle()
                            self.activeSheet = .second
                            self.activeDeck = self.deck
                        }) {
                            Image(systemName: "plus.app")
                                .font(.system(size: 38, weight: .semibold))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                            )
                                .foregroundColor(.grayFont)
                                .padding(.top, 5)
                                .padding(.bottom)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                        }
                    }
                }
            }
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
