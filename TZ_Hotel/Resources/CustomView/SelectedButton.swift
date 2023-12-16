//
//  SelectedButton.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct SelectedButton: View {
    let buttonText: String
    var buttonHeight: CGFloat = 48
    var buttonColor: Color = Constants.Colors.buttonBlueTint
    var buttonRadius: CGFloat = 15

    var action: () -> Void
    var body: some View {
        HStack(alignment: .center) {
            Button {
                action()
            } label: {
                Spacer()
                Text(buttonText)
                    .font(Font(Constants.Fonts.headline3))
                    .foregroundColor(Constants.Colors.headline3)
                Spacer()
            }
            .frame(height: buttonHeight)
            .background(buttonColor)
            .cornerRadius(buttonRadius)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
    }
}
