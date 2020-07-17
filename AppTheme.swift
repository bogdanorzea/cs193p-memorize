//
//  AppTheme.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/16/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct AppTheme<CardContent> {
    private(set) var name: String
    private(set) var numberOfPairsToShow: Int
    private(set) var emojisToUse: [CardContent]
    private(set) var color: Color

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
