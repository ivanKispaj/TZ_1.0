//
//  BookingViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI
struct FieldsValidationState {
    var isValidNumber: Bool = true
    var isValidEmail: Bool = true
    var isValidTouristFields: Bool = true
    func isValidFields() -> Bool {
        isValidNumber && isValidEmail && isValidTouristFields
    }
}

class BookingViewModel: BookingViewModelProtocol {
    @Published var viewData: BookingParseModel?
    @Published var tourists: [TouristModel] = [TouristModel()]
    @Published var validState = FieldsValidationState()

    let networkService: any NetworkServiceProtocol

    let textFieldVAlidator: TextFieldValidator

    init(viewData _: BookingParseModel? = nil, service: any NetworkServiceProtocol) {
        networkService = service
        textFieldVAlidator = TextFieldValidator()
    }

    func fetchData() {
        guard let url = Constants.ApiURL.bookingSceneUrl else { return }

        DispatchQueue.global(qos: .userInteractive).async {
            self.networkService.loadDataToDecodableModel(url: url) { response, error in
                guard error == nil else { return }
                guard let booking = response as? BookingParseModel else { return }
                DispatchQueue.main.async {
                    self.viewData = booking
                }
            }
        }
    }

    func verifyInputData(phone: String, email: String) -> Bool {
        validState.isValidNumber = textFieldVAlidator.validatePhoneNumber(phone)
        validState.isValidEmail = textFieldVAlidator.validateEmail(email)
        textFieldVAlidator.validateTouristFields(tourists) { [weak self] index, state in
            guard let self = self else { return }
            if let index = index {
                self.tourists[index].isValidData = state
                self.validState.isValidTouristFields = state
            }
        }
        return validState.isValidFields()
    }

    func formatedPhoneNumber(_ value: String?) -> String? {
        guard let formatter = viewData?.formatter else { return "" }

        return formatter.formattesPhone(value: value)
    }
}
