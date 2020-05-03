//
//  DeckFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckFormView: View {
    @Environment (\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var color: String = ""
    @State private var showingValidationAlert = false
    @State private var showingDeleteAlert = false
    var deck: Deck?
    
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 5) {
                    VStack {
                        Image(systemName: "square.stack.3d.down.right")
                            .frame(width: 32, height: 32)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.firstColor)
                        Text("Deck")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Name")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }.frame(width: 250)
                    
                    ZStack {
                        TextField("", text: $name)
                            .frame(width: 250, height: 40)
                            .background(Color.backgroundColor)
                            .cornerRadius(5)
                        HStack {
                            Spacer()
                            Button(action: { self.name = "" })
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.tertiaryBackgroundColor)
                            }
                            .padding(.trailing, 8)
                        }.frame(width: 250)
                    }.padding(.bottom, 20)
                    
                    HStack {
                        Text("Color")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }
                    .frame(width: 250)
                    .padding(.bottom, 15)
                    
                    HStack {
                        ForEach(0 ..< deckColors.count) { value in
                            Button(action:
                                {
                                    self.color = deckColors[value].name
                            })
                            {
                                Circle()
                                    .fill(deckColors[value].colorOne)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.tertiaryBackgroundColor, lineWidth: self.color == deckColors[value].name ? 4 : 1)
                                )
                                    .frame(width: 22, height: 22)
                            }
                            if value != deckColors.count - 1 {
                                Spacer()
                            }
                        }
                    }.frame(maxWidth: 250)
                    
                    Spacer()
                    
                    if (self.deck != nil) {
                        Button(action: {
                            self.showingDeleteAlert = true
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(Color.white)
                                .frame(width: 64, height: 64)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        .padding(.bottom, 50)
                        .alert(isPresented: $showingDeleteAlert) { () -> Alert in
                            Alert(title: Text("Are you sure?"), message: Text("Deck and its flashcards will be deleted permanently."),
                                  primaryButton: .default(Text("Yes"), action: {
                                    self.gameStatus.delete(deck: self.deck!)
                                    self.presentationMode.wrappedValue.dismiss()
                                  }),
                                  secondaryButton: .default(Text("Cancel")))
                        }
                    }
                    
                }.navigationBarTitle("", displayMode: .inline)
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = UIColor.backgroundColor
                    })
                    .navigationBarItems(
                        leading:
                        Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Cancel").foregroundColor(Color.firstColor).font(.system(size: 18, weight: .semibold)) },
                        trailing: Button(action: {
                            if (self.deck == nil) {
                                self.gameStatus.save(name: self.name, color: self.color)
                                self.presentationMode.wrappedValue.dismiss()
                                return
                            }
                            if self.name == "" {
                                self.showingValidationAlert = true
                            } else {
                                self.gameStatus.save(deck: self.deck!, name: self.name, color: self.color)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Done")
                                .foregroundColor(Color.firstColor)
                                .font(.system(size: 18, weight: .semibold))
                                .alert(isPresented: $showingValidationAlert) {
                                    Alert(
                                        title: Text("Error"),
                                        message: Text("Name can not be empty"),
                                        dismissButton: .default(Text("Got it!"))
                                    )
                            }
                        }
                )
                    .onAppear {
                        self.name = self.deck?.wrappedName ?? self.name
                        self.color = self.deck?.wrappedColor ?? self.color
                }
            }
        }
    }
}


struct DeckFormView_Previews: PreviewProvider {
    static var previews: some View {
        DeckFormView()
    }
}