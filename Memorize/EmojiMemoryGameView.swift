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

    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(color)
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }

    // MARK: - Drawing constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
