//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var gamePlay: GamePlay
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.backgroundColor
                
                VStack {
                    if self.viewRouter.currentView == Homepapge.dictionary {
                        DictionaryView().onAppear() {
                            self.gamePlay.stop()
                            self.gamePlay.reset()
                        }
                    } else if self.viewRouter.currentView == Homepapge.game {
                        GameView()
                    }
                    
                    Spacer()
                    
                    if !self.gamePlay.isGameStarted {
                        TabView(geometry: geometry)
                            .frame(height: UIScreen.main.bounds.height * 0.1)
                            .border(Color.borderColor)
                            .background(Color.backgroundColor)
                    }
                }

                if self.activeSheetHandler.showSheet {
                    ActiveSheetView()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        let env = ViewRouter()
        return HomepageView().environmentObject(env).environmentObject(gameStatus)
    }
}
