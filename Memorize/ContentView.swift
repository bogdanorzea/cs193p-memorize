//
//  ContentView.swift
//  Memorize
//
//  Created by Bogdan Orzea on 5/28/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards.shuffled()) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        self.viewModel.choseCard(card: card)
                }
            }
        }
        .foregroundColor(Color.orange)
        .font(viewModel.cards.count == 2*5 ? Font.title : Font.largeTitle)
        .padding()
    }
}



struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if (card.isFaceUp) {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.orange)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
