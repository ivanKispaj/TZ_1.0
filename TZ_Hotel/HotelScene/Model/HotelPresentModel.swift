//
//  HotelPresentModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import UIKit

struct HotelPresentModel: Identifiable {
    private var formatter = Formatter()

    let id: Int
    let name: String
    let adress: String
    private let minPrice: Int
    let priceDescription: String
    let rating: String
    let ratingDescription: String
    var imageData: [UIImage]
    let hotelDescription: String
    private let peculiarities: [String]

    init(data: HotelParseModel) {
        id = data.id
        name = data.name
        adress = data.adress
        minPrice = data.minPrice
        priceDescription = data.priceDescription
        rating = String(data.rating)
        ratingDescription = data.ratingDescription
        imageData = []
        hotelDescription = data.aboutTheHotel.hotelDescription
        peculiarities = data.aboutTheHotel.peculiarities
    }

    func getPeculiarities(font: UIFont, padding: CGFloat) -> [[String]] {
        peculiarities.createLineArrsString(font, padding)
    }

    func getMinPrice() -> String {
        formatter.iтtegerToMoneyString(minPrice, with: "₽")
    }
}
