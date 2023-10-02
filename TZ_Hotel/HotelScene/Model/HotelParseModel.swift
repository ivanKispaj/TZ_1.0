//
//  HotelModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation



struct HotelParseModel: Decodable
{
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case adress
        case minPrice = "minimal_price"
        case priceDescription = "price_for_it"
        case rating
        case ratingDescription = "rating_name"
        case imageUrl = "image_urls"
        case aboutTheHotel = "about_the_hotel"
        
    }
    
    let id: Int
    let name: String
    let adress: String
    let minPrice: Int
    let priceDescription: String
    let rating: Int
    let ratingDescription: String
    let imageUrls: [String]
    let aboutTheHotel: AboutHotel
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        adress = try container.decode(String.self, forKey: .adress)
        minPrice = try container.decode(Int.self, forKey: .minPrice)
        priceDescription = try container.decode(String.self, forKey: .priceDescription)
        rating = try container.decode(Int.self, forKey: .rating)
        ratingDescription = try container.decode(String.self, forKey: .ratingDescription)
        imageUrls = try container.decode([String].self, forKey: .imageUrl)
        aboutTheHotel = try container.decode(AboutHotel.self, forKey: .aboutTheHotel)
        
    }
    
    struct AboutHotel: Decodable
    {
        enum CodingKeys: String, CodingKey
        {
            case hotelDescription = "description"
            case peculiarities
        }
        let hotelDescription: String
        let peculiarities: [String]
        
        init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            hotelDescription = try container.decode(String.self, forKey: .hotelDescription)
            peculiarities = try container.decode([String].self, forKey: .peculiarities)
        }
    }
}
