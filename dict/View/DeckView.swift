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
    @Binding var activeFlashCard: FlashCard
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
                Spacer()
            }.padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    HStack {
                        ForEach(self.flashCards, id: \.self) { flashCard in
                            Button(action: {
                                self.showSheet.toggle()
                                self.activeSheet = .flashCardEditForm
                                self.activeDeck = self.deck
                                self.activeFlashCard = flashCard
                            }) {
                                MiniFlashCardView(flashCard: flashCard)
                            }
                        }
                        Button(action: {
                            self.showSheet.toggle()
                            self.activeSheet = .flashCardForm
                            self.activeDeck = self.deck
                        }) {
                            Image(systemName: "plus.app")
                                .font(.system(size: 38, weight: .semibold))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                            )
                                .foregroundColor(.secondaryBackgroundColor)
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
