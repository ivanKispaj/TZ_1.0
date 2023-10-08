//
//  HotelInfoView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI

struct HotelInfoView: View {
    var viewData: HotelPresentModel

    var body: some View {
        VStack {
            CarouselImage(item: viewData.imageData)
            rating()
            hotelName()
            hotelAdress()
            priceFortour()
        }
        .background(Constants.Colors.white)
        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
    }

    // MARK: - Rating view

    @ViewBuilder func rating() -> some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(Constants.Colors.ratingColor)
                    .frame(width: 15, height: 15)
                Text(String(viewData.rating))
                    .font(Font(Constants.Fonts.sfpro16Regular))
                    .foregroundColor(Constants.Colors.ratingColor)
                Text(viewData.ratingDescription)
                    .font(Font(Constants.Fonts.sfpro16Regular))
                    .foregroundColor(Constants.Colors.ratingColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(height: 29)
            .background(Constants.Colors.ratingBackground)
            .cornerRadius(5)
            Spacer()
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }

    // MARK: - hotel name

    @ViewBuilder func hotelName() -> some View {
        HStack {
            Text(viewData.name)
                .font(Font(Constants.Fonts.sfpro22Regular))
                .foregroundColor(Constants.Colors.black)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }

    @ViewBuilder func hotelAdress() -> some View {
        HStack {
            Button(viewData.adress) {
                // any action
            }
            .font(Font(Constants.Fonts.sfpro14Regular))
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }

    @ViewBuilder func priceFortour() -> some View {
        HStack(alignment: .bottom) {
            Text("от")
                .font(Font(Constants.Fonts.sfpro30Medium))
                .foregroundColor(Constants.Colors.black)
            Text(viewData.getMinPrice())
                .foregroundColor(Constants.Colors.black)
                .font(Font(Constants.Fonts.sfpro30Medium))
            Text(viewData.priceDescription)
                .font(Font(Constants.Fonts.sfpro14Light))
                .foregroundColor(Constants.Colors.greyTintColor)
            Spacer()
        }

        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
    }
}
