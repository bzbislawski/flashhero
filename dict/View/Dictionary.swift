//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case deckForm, flashCardForm, deckEditForm, flashCardEditForm
}

struct Dictionary: View {
    @EnvironmentObject var gameStatus: GameStatus
    @FetchRequest(entity: Deck.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Deck.createdAt, ascending: true)
    ]) var decks: FetchedResults<Deck>
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .deckForm
    @State private var activeDeck: Deck = Deck()
    @State private var activeFlashCard: FlashCard = FlashCard()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Swipe right to play a deck")
                        .italic()
                        .font(.subheadline)
                        .fontWeight(.ultraLight)
                        .padding(.leading, 20)
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(decks, id: \.self) { deck in
                        DeckView(showSheet: self.$showSheet, activeSheet: self.$activeSheet, activeDeck: self.$activeDeck, activeFlashCard: self.$activeFlashCard, deck: deck)
                    }
                }
            }
            .navigationBarTitle("Dictionary")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showSheet.toggle()
                    self.activeSheet = .deckForm
                }, label: {
                    Image(systemName: "plus.app")
                        .frame(width: 44, height: 44)
                        .font(.system(size: 26, weight: .semibold))
                }).sheet(isPresented: $showSheet) {
                    if self.activeSheet == .deckForm {
                        DeckFormView().environmentObject(self.gameStatus)
                    } else if (self.activeSheet == .deckEditForm) {
                        DeckFormView(deck: self.activeDeck).environmentObject(self.gameStatus)
                    } else if (self.activeSheet == .flashCardForm) {
                        FlashCardFormView(deck: self.activeDeck).environmentObject(self.gameStatus)
                    } else if (self.activeSheet == .flashCardEditForm) {
                        FlashCardFormView(deck: self.activeDeck, flashCard: self.activeFlashCard).environmentObject(self.gameStatus)
                    }
                }
            )
        }
    }
}

//#if debug
struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
//#endif
