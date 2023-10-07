//
//  BookingViewModelProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import SwiftUI

protocol BookingViewModelProtocol: ObservableObject, ViewModelProtocol {
    var viewData: BookingParseModel? { get set }
    var tourists: [TouristModel] { get set }
    var validState: Int { get set }
    var textFieldVAlidator: TextFieldValidator { get }

    func verifyInputData(phone: String, email: String) -> Bool
    func formatedPhoneNumber(_ value: String?) -> String?
}
