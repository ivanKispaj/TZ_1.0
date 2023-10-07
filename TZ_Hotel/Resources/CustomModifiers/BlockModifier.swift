//
//  BlockModifier.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 07.10.2023.
//

import SwiftUI

struct BlockModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .background(color)
            .cornerRadius(radius)
    }
}

extension View {
    func blockStyle(color: Color, radius: CGFloat = 12) -> some View {
        modifier(BlockModifier(color: color, radius: radius))
    }
}
