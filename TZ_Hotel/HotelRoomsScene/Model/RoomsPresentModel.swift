//
//  RoomsPresentModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import UIKit

struct RoomsPresentModel: Identifiable, Hashable
{
    let id: Int
    let name: String
    let price: Int
    let priceDescription: String
    let peculiarties: [String]
    var imgData: [UIImage]
}
