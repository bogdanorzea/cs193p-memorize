//
//  ContentView.swift
//  Memorize
//
//  Created by Bogdan Orzea on 5/28/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            HStack {
                Text("Score: \(self.viewModel.score)")
                Spacer()
                NewGameButton { self.viewModel.reset() }
            }.padding()
            Text("Game theme: \(viewModel.theme.name)")
            Grid(viewModel.cards) { card in
                CardView(card: card, color: self.viewModel.theme.color).onTapGesture {
                    self.viewModel.choseCard(card: card)
                }
                .padding(5)
            }
            .foregroundColor(viewModel.theme.color)
            .padding()
        }
    }
}

struct NewGameButton: View {
    @State var showNewGameAlert = false
    var action: () -> Void

    var body: some View {
        Button(action: { self.showNewGameAlert = true }, label: {
            Text("New game")
                .padding()
                .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth))
        })
            .alert(isPresented: self.$showNewGameAlert, content: { () -> Alert in
                Alert(
                    title: Text("Start a new game?"),
                    message: Text("Starting a new game will reset your current game"),
                    primaryButton: .default(Text("Yes"), action: action ),
                    secondaryButton: .cancel()
                )
            })
    }

    // MARK: - Drawing constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 2.0
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(
                    startAngle: Angle.degrees(0-90),
                    endAngle: Angle.degrees(110-90),
                    clockwise: true
                ).padding(5).opacity(0.5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp, color: color)
        }
    }

    // MARK: - Drawing constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choseCard(card: game.cards[0])

        return ContentView(viewModel: game)
    }
}
