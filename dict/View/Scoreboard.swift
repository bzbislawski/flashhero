//
//  Scoreboard.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/12/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Scoreboard: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        let totalScore = self.gameStatus.correctAnswers + self.gameStatus.wrongAnswers
        let score = Float(self.gameStatus.correctAnswers) / Float(totalScore)
        let winGame = score > 0.6
        return VStack {
            Text(winGame ? "Congrats!" : "Whoops!")
                .font(.system(size: 26, weight: .bold))
                .padding(.all)
                .frame(width: 240)
            
            Image(systemName: winGame ? "checkmark.seal.fill" : "xmark.seal.fill")
                .font(.system(size: 46, weight: .medium))
            
            Text("Score:")
                .padding(.top)
            
            Text(String(self.gameStatus.correctAnswers) + "/" + String(totalScore))
                .font(.system(size: 32, weight: .medium))
                .padding(.bottom)
            
            Button(action: {
                self.gameStatus.resetGame()
            }) {
                VStack {
                    Text("Restart the game")
                        .frame(width: 160, height: 40)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("GreenFont"))
                }
                .background(Color("Gray"))
                .cornerRadius(5)
            }.padding(.bottom, 25)
        }
        .frame(width: 280)
        .background(winGame ? Color("Success") : Color("Failure"))
        .cornerRadius(40)
        .overlay(RoundedRectangle(cornerRadius: 40).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
        .shadow(radius: 20, x: 0, y: 20)
        .foregroundColor(Color("Gray"))
    }
}

struct Scoreboard_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let gs = GameStatus(flashCardRepository: repository)
        let gs2 = GameStatus(flashCardRepository: repository)
        gs.correctAnswers = 5
        gs2.correctAnswers = 0
        return VStack {
            Scoreboard().environmentObject(gs)
            Spacer()
            Scoreboard().environmentObject(gs2)
        }
    }
}
