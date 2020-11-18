//
//  Data+UTF8.swift
//  Memorize
//
//  Created by Bogdan Orzea on 11/17/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8)}
}
