//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bogdan Orzea on 6/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }

        cards = cards.shuffled()
    }

    mutating func choose(card: Card) {
        print("Card was chosen: \(card)")
        let chosenIndex = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }

    func index(of card: Card) -> Int {
        if let index = self.cards.firstIndex(where: { $0.id == card.id }) {
            return index
        }

        return 0 // TODO: remove this return
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
