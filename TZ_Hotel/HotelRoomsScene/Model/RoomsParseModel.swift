//
//  RoomsParseModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation

struct RoomsParseModel: Decodable {
    let rooms: [Room]
}

struct Room: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case priceDescription = "price_per"
        case peculiarities
        case imgUrl = "image_urls"
    }

    let id: Int
    let name: String
    let price: Int
    let priceDescription: String
    let peculiarities: [String]
    let imgUrl: [String]
}
