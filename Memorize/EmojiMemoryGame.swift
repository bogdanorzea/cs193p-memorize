//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bogdan Orzea on 6/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var appTheme: AppTheme<String>
    @Published private var model: MemoryGame<String>

    init() {
        let index = Int.random(in: 0..<EmojiMemoryGame.appThemes.count)

        self.appTheme = EmojiMemoryGame.appThemes[index]
        self.model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.appThemes[index])
    }

    static let appThemes = [
        AppTheme<String>(name: "Haloween", numberOfPairsToShow: 6, emojisToUse: ["🎃", "👻", "🕷", "🧟‍♂️", "🧛🏻‍♂️", "☠️"], color: .orange),
        AppTheme<String>(name: "Smiley faces", numberOfPairsToShow: 4, emojisToUse: ["😃", "😘", "😎", "😷", "😰"], color: .yellow),
        AppTheme<String>(name: "Sports", numberOfPairsToShow: Int.random(in: 2...5), emojisToUse: ["⚽️", "🏀", "🏈", "🏐", "🎱", "⛳️", "🏓", "🏑", "🎣", "🤾"], color: .green),
        AppTheme<String>(name: "Numbers", numberOfPairsToShow: 10, emojisToUse: ["0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣"], color: .blue)
    ]

    static func createMemoryGame(theme: AppTheme<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsToShow) { pairIndex in theme.emojisToUse[pairIndex] }
    }

    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    var theme: AppTheme<String> {
        return appTheme
    }

    // MARK: - Intent(s)
    func choseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
