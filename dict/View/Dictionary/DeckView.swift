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
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    var deck: Deck
    
    var flashCards: [FlashCard] {
        deck.flashCardArray
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.activeSheetHandler.showSheet.toggle()
                    self.activeSheetHandler.activeSheet = .deckForm
                    self.activeSheetHandler.activeDeck = self.deck
                }) {
                    HStack {
                        Image(systemName: "folder")
                        Text(deck.wrappedName).font(.system(size: 20, weight: .semibold))
                    }
                    .padding(.leading, 30)
                    .foregroundColor(Color.darkBlue)
                }
                
                Spacer()
            }
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ZStack {
                    Color.white
                        .cornerRadius(12)
                        .frame(minWidth: UIScreen.main.bounds.width - 40)
                    HStack {
                        ForEach(self.flashCards, id: \.self) { flashCard in
                            MiniFlashCardView(deck: self.deck, flashCard: flashCard).onTapGesture {
                                self.activeSheetHandler.showSheet.toggle()
                                self.activeSheetHandler.activeSheet = .flashCardForm
                                self.activeSheetHandler.activeDeck = self.deck
                                self.activeSheetHandler.activeFlashCard = flashCard
                            }
                            .frame(width: 150, height: 100)
                            .padding(.leading, 20)
                        }
                        
                        Button(action: {
                            self.activeSheetHandler.showSheet.toggle()
                            self.activeSheetHandler.activeSheet = .flashCardForm
                            self.activeSheetHandler.activeDeck = self.deck
                            self.activeSheetHandler.activeFlashCard = nil
                        }) {
                            Image(systemName: "plus.app")
                                .font(.system(size: 38, weight: .semibold))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                            )
                                .foregroundColor(.secondaryBackgroundColor)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
    }
    
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        
        let deck = Deck(context: context)
        deck.name = "Deck name"
        deck.color = "blue"
        
        let flashCard = FlashCard(context: context)
        flashCard.word = "Kitchen"
        flashCard.translation = "Kuchnia"
        deck.addToFlashCard(flashCard)
        
        let flashCard2 = FlashCard(context: context)
        flashCard.word = "Room"
        flashCard.translation = "Pokoj"
        deck.addToFlashCard(flashCard2)
        
        try? context.save()
        return DeckView(deck: deck).environmentObject(gameStatus)
    }
}
