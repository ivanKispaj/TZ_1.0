//
//  RoomsSingleView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI

struct RoomsSingleView: View {
    @Binding var viewData: RoomsPresentModel
    var body: some View {
        CarouselImage(item: viewData.imgData)
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        Text(viewData.name)
            .fontWithForeground(font: Font(Constants.Fonts.sfpro22Regular),
                                color: Constants.Colors.black)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        GroupedText(data: viewData.getPeculiarities(font: Constants.Fonts.sfpro16Regular, padding: 30))
        buttonInfo()
        HStack(alignment: .bottom) {
            Text(viewData.getPrice())
                .fontWithForeground(font: Font(Constants.Fonts.sfpro30Medium),
                                    color: Constants.Colors.black)
            Text(viewData.priceDescription)
                .fontWithForeground(font: Font(Constants.Fonts.sfpro14Light),
                                    color: Constants.Colors.greyTintColor)
                .padding(5)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }

    @ViewBuilder private func buttonInfo() -> some View {
        VStack {
            Button {
                // Some Action
            } label: {
                HStack(alignment: .center) {
                    Text("Подробнее о номере")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular),
                                            color: Constants.Colors.buttonBlueTint)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                }
            }
            .frame(height: 29)
            .blockStyle(color: Constants.Colors.buttonBackGRopac10, radius: 5)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }
}
