//
//  TouristModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import Foundation

struct TouristModel: Hashable, Equatable, Identifiable {
    var id: String = UUID().uuidString
    var phoneNumber: String = ""
    var email: String = ""
    var name: String = ""
    var lastName: String = ""
    var birthDate: String = ""
    var nationality: String = ""
    var passportCode: String = ""
    var passportValidityPeriod: String = ""
    var isValidData: Bool = true
}
