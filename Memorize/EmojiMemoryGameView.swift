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
                NewGameButton {
                    withAnimation(.easeInOut) { self.viewModel.reset() }
                }
            }.padding()
            Text("Game theme: \(viewModel.theme.name)")
            Grid(viewModel.cards) { card in
                CardView(card: card, color: Color(self.viewModel.theme.color))
                    .onTapGesture {
                        withAnimation {
                            self.viewModel.choseCard(card: card)
                        }
                    }
                    .padding(5)
            }
            .foregroundColor(Color(viewModel.theme.color))
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

    @State private var animatedBonusRemaining: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear { self.startBonusTimeAnimation() }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                    .padding(5)
                    .opacity(0.5)
                    .transition(.scale)

                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)
            }
                .cardify(isFaceUp: card.isFaceUp, color: color)
                .transition(.scale)
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
