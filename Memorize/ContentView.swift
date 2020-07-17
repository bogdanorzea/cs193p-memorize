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

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    func body(for size: CGSize) -> some View {
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
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
