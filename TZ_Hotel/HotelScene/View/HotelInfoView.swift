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
        VStack(spacing: 10) {
            CarouselImage(item: viewData.imageData)
            RatingView(text: viewData.rating + " " + viewData.ratingDescription)
            hotelName()
            hotelAdress()
            priceFortour()
        }
        .background(Constants.Colors.white)
        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }

    // MARK: - hotel name

    @ViewBuilder private func hotelName() -> some View {
        HStack {
            Text(viewData.name)
                .font(Font(Constants.Fonts.sfpro22Medium))
                .foregroundColor(Constants.Colors.black)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }

    // MARK: - Hotel adress

    @ViewBuilder private func hotelAdress() -> some View {
        HStack {
            Button(viewData.adress) {
                // any action
            }
            .font(Font(Constants.Fonts.sfpro14Regular))
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }

    // MARK: - Price for tour

    @ViewBuilder private func priceFortour() -> some View {
        HStack(alignment: .bottom) {
            Text("от")
                .font(Font(Constants.Fonts.sfpro30Semibold))
                .foregroundColor(Constants.Colors.black)
            Text(viewData.getMinPrice())
                .foregroundColor(Constants.Colors.black)
                .font(Font(Constants.Fonts.sfpro30Semibold))
            Text(viewData.priceDescription)
                .font(Font(Constants.Fonts.sfpro16Regular))
                .foregroundColor(Constants.Colors.greyTintColor)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
    }
}
