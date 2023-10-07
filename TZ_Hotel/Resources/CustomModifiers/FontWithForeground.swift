//
//  FontWithForeground.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 07.10.2023.
//

import SwiftUI

struct FontWithForeground: ViewModifier {
    var font: Font
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension View {
    func fontWithForeground(font: Font, color: Color) -> some View {
        modifier(FontWithForeground(font: font, color: color))
    }
}
