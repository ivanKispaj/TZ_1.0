//
//  HotelPresentModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import UIKit

struct HotelPresentModel: Identifiable
{
    let id: Int
    let name: String
    let adress: String
    let minPrice: Int
    let priceDescription: String
    let rating: Int
    let ratingDescription: String
    var imageData: [UIImage]
    let hotelDescription: String
    let peculiarities: [String]
    
    init(id: Int, name: String, adress: String, minPrice: Int, priceDescription: String, rating: Int, ratingDescription: String, imageData: [UIImage], hotelDescription: String, peculiarities: [String]) {
        self.id = id
        self.name = name
        self.adress = adress
        self.minPrice = minPrice
        self.priceDescription = priceDescription
        self.rating = rating
        self.ratingDescription = ratingDescription
        self.imageData = imageData
        self.hotelDescription = hotelDescription
        self.peculiarities = peculiarities
    }
}

