//
//  AppTheme.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/16/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct AppTheme<CardContent>: Codable where CardContent: Codable {
    private(set) var name: String
    private(set) var numberOfPairsToShow: Int
    private(set) var emojisToUse: [CardContent]
    private(set) var color: UIColor.RGB

    init(name: String, numberOfPairsToShow: Int?, emojisToUse: [CardContent], color: UIColor) {
        self.name = name
        self.numberOfPairsToShow = Int.random(in: 2...emojisToUse.count)
        self.emojisToUse = emojisToUse
        self.color = color.rgb
    }

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}
