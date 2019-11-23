//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Game: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var showAnswer = false
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    func textView(text: String, isAnswer: Bool) -> some View {
        Text(text)
            .bold()
            .font(.title)
            .rotation3DEffect(Angle(degrees: isAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .onTapGesture {
                print(self.showAnswer)
                self.showAnswer.toggle()
            }
            .animation(self.animation)
            .gesture(DragGesture()
                .onChanged { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
                }
                .onEnded { value in
                    self.currentPosition = CGSize.zero
                    print(self.newPosition.width)
                    self.newPosition = self.currentPosition
                })
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                FlashCardView(showAnswer: self.$showAnswer, word: "Kot", translation: "Answer").offset(y: -30).scaleEffect(0.95)
                ZStack {
                        self.textView(text: "Psiaczek", isAnswer: true)
                            .zIndex(self.showAnswer ? 1 : 0)
                    
                        Image("rectangle")
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 320, height: 220)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                            .shadow(radius: 5)
                            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                            .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                            .onTapGesture {
                                print(self.showAnswer)
                                self.showAnswer.toggle()
                            }
                            .animation(self.animation)
                            .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
                            }
                            .onEnded { value in
                                self.currentPosition = CGSize.zero
                                print(self.newPosition.width)
                                self.newPosition = self.currentPosition
                            })
                    
                        self.textView(text: "Mietek", isAnswer: false)
                            .zIndex(self.showAnswer ? -1 : 0)
                }
                
            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}