//
//  AppTheme.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/16/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct AppTheme<CardContent> {
    var name: String
    var numberOfPairsToShow: Int
    var emojisToUse: [CardContent]
    var color: Color

    init(name: String, numberOfPairsToShow: Int?, emojisToUse: [CardContent], color: Color) {
        self.name = name
        self.numberOfPairsToShow = Int.random(in: 2...emojisToUse.count)
        self.emojisToUse = emojisToUse
        self.color = color
    }

    init(name: String, emojisToUse: [CardContent], color: Color) {
        let numberOfPairsToShow = Int.random(in: 2...emojisToUse.count)

        self.init(name: name, numberOfPairsToShow: numberOfPairsToShow, emojisToUse: emojisToUse, color: color)
    }
}
