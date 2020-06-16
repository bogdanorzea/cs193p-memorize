//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bogdan Orzea on 6/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🎃", "👻", "🕷", "🧟‍♂️", "🧛🏻‍♂️", "🍂", "🧨", "🦠", "🧿", "🃏", "🦃", "☠️"].shuffled()
        let pairsOfCards = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: pairsOfCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
