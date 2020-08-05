//
//  Cardify.swift
//  Memorize
//
//  Created by Bogdan Orzea on 7/20/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var color: Color
    var rotation: Double

    init(isFaceUp: Bool, color: Color) {
        self.rotation = isFaceUp ? 0 : 180
        self.color = color
    }

    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }

    // MARK: - Drawing constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) ->  some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
