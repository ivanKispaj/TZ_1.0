//
//  HotelDescriptionView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI
struct HotelDescriptionView: View {
    var viewData: HotelPresentModel
    var body: some View {
        VStack(alignment: .leading) {
            aboutHotel()
            pecularities()
            comfort()
        }
        .blockStyle(color: Constants.Colors.white)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
    }

    // MARK: - about hotel

    @ViewBuilder func aboutHotel() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Об отеле")
                    .font(Font(Constants.Fonts.sfpro22Regular))
                    .foregroundColor(Constants.Colors.black)
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        }
    }

    // MARK: - pecilarities

    @ViewBuilder private func pecularities() -> some View {
        ForEach(viewData.getPeculiarities(font: Constants.Fonts.sfpro16Regular, padding: 30), id: \.self) { arr in
            HStack(spacing: 0) {
                ForEach(arr, id: \.self) { word in
                    Text(word)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .font(Font(Constants.Fonts.sfpro16Regular))
                        .background(Constants.Colors.backGroundPeculiarities)
                        .foregroundColor(Constants.Colors.greyTintColor)
                        .cornerRadius(5)
                    Spacer()
                        .frame(width: 5, alignment: .leading)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        }

        VStack {
            Text(viewData.hotelDescription)
                .foregroundColor(Constants.Colors.colorDescription)
                .font(Font(Constants.Fonts.sfpro16Light))
                .multilineTextAlignment(.leading)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }

    // MARK: - comfort

    @ViewBuilder func comfort() -> some View {
        VStack(spacing: 0) {
            button(imageName: Constants.ImagesName.emojiHappy, text: "Удобства", subText: "Самое необходимое")
            devider()
            button(imageName: "tickSquare", text: "Что включено", subText: "Самое необходимое")
            devider()
            button(imageName: "closeSquare", text: "Что не включено", subText: "Самое необходимое")
        }
        .blockStyle(color: Constants.Colors.buttonGrayBackground)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }

    // MARK: - button

    @ViewBuilder func button(imageName: String, text: String, subText: String) -> some View {
        Button {
            // some action
        } label: {
            HStack(alignment: .center) {
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Constants.Colors.buttonTitleBlack)
                VStack(alignment: .leading) {
                    Text(text)
                        .font(Font(Constants.Fonts.sfpro16Regular))
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    Text(subText)
                        .font(Font(Constants.Fonts.sfpro14Regular))
                        .foregroundColor(Constants.Colors.greyTintColor)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                Spacer()

                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 6, height: 12)
                    .foregroundColor(Constants.Colors.buttonTitleBlack)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .frame(height: 38)
        .padding(10)
    }

    // MARK: - Divider

    @ViewBuilder func devider() -> some View {
        Divider()
            .foregroundColor(Constants.Colors.derivrdColor)
            .padding(EdgeInsets(top: 0, leading: 65, bottom: 0, trailing: 10))
            .background(Constants.Colors.buttonGrayBackground)
    }
}
