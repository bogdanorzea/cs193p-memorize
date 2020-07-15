//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/14/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            // swiftlint:disable:next for_where
            if self[index].id == matching.id {
                return index
            }
        }

        return nil
    }
}
