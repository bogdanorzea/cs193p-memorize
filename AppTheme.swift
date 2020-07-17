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
}
