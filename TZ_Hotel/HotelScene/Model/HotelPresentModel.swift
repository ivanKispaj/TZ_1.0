//
//  HotelPresentModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import UIKit

struct HotelPresentModel: Identifiable
{
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
        self.id = data.id
        self.name = data.name
        self.adress = data.adress
        self.minPrice = data.minPrice
        self.priceDescription = data.priceDescription
        self.rating = String(data.rating)
        self.ratingDescription = data.ratingDescription
        self.imageData = []
        self.hotelDescription = data.aboutTheHotel.hotelDescription
        self.peculiarities = data.aboutTheHotel.peculiarities
    }

    func getPeculiarities(font: UIFont, padding: CGFloat) -> [[String]]
    {
        peculiarities.createLineArrsString(font, padding)
    }
    
    func getMinPrice() -> String
    {
        formatter.iтtegerToMoneyString(minPrice, with: "₽")
    }
}

