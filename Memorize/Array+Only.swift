//
//  Array+Only.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/15/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
