//
//  RatingView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI

struct RatingView: View {
    let text: String
    let systemImage: String = "star.fill"
    let foreground: Color = Constants.Colors.ratingColor
    let background: Color = Constants.Colors.ratingBackground
    let font: Font = .init(Constants.Fonts.sfpro16Regular)
    let radius: CGFloat = 5
    let height: CGFloat = 29
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(foreground)
                    .frame(width: 15, height: 15)
                Text(text)
                    .fontWithForeground(font: font, color: foreground)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(height: height)
            .background(background)
            .cornerRadius(radius)
            Spacer()
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}
