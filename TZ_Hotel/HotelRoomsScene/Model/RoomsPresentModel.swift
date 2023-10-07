//
//  RoomsPresentModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import UIKit

struct RoomsPresentModel: Identifiable, Hashable {
    static func == (lhs: RoomsPresentModel, rhs: RoomsPresentModel) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    private var formatter = Formatter()

    let id: Int
    let name: String
    private let price: Int
    let priceDescription: String
    private let peculiarities: [String]
    var imgData: [UIImage]

    init(data: Room) {
        id = data.id
        name = data.name
        price = data.price
        priceDescription = data.priceDescription
        peculiarities = data.peculiarities
        imgData = []
    }

    func getPrice() -> String {
        formatter.iтtegerToMoneyString(price, with: "₽")
    }

    func getPeculiarities(font: UIFont, padding: CGFloat) -> [[String]] {
        peculiarities.createLineArrsString(font, padding)
    }
}
