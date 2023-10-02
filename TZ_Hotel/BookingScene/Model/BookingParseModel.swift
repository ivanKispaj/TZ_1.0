//
//  BookingParseModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import Foundation

struct BookingParseModel: Decodable, Identifiable
{
    enum CodingKeys: String, CodingKey
    {
        case id
        case hotelName = "hotel_name"
        case hotelAdress = "hotel_adress"
        case hotelRating = "horating"
        case ratingDescription = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourStartDate = "tour_date_start"
        case tourStopDate = "tour_date_stop"
        case countOfNights = "number_of_nights"
        case room
        case nutrition
        case tourPrice = "tour_price"
        case fuelChange = "fuel_charge"
        case serviceChange = "service_charge"
        
        
    }
    let id: Int
    let hotelName: String
    let hotelAdress: String
    let hotelRating: Int
    let ratingDescription: String
    let departure: String
    let arrivalCountry: String
    let tourStartDate: String
    let tourStopDate: String
    let countOfNights: Int
    let room: String
    let nutrition: String
    let tourPrice: Int
    let fuelChange: Int
    let serviceChange: Int
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        hotelName = try container.decode(String.self, forKey: .hotelName)
        hotelAdress = try container.decode(String.self, forKey: .hotelAdress)
        hotelRating = try container.decode(Int.self, forKey: .hotelRating)
        ratingDescription = try container.decode(String.self, forKey: .ratingDescription)
        departure = try container.decode(String.self, forKey: .departure)
        arrivalCountry = try container.decode(String.self, forKey: .arrivalCountry)
        tourStartDate = try container.decode(String.self, forKey: .tourStartDate)
        tourStopDate = try container.decode(String.self, forKey: .tourStopDate)
        countOfNights = try container.decode(Int.self, forKey: .countOfNights)
        room = try container.decode(String.self, forKey: .room)
        nutrition = try container.decode(String.self, forKey: .nutrition)
        tourPrice = try container.decode(Int.self, forKey: .tourPrice)
        fuelChange = try container.decode(Int.self, forKey: .fuelChange)
        serviceChange = try container.decode(Int.self, forKey: .serviceChange)
    }
}
