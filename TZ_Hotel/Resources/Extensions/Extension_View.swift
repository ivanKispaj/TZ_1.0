//
//  Extension_View.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import SwiftUI
import UIKit

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
