//
//  TextFieldValidator.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import Foundation

class TextFieldValidator {
    private var validState: Int = 0

    var none: Int {
        return 0
    }

    var numberValid: Int {
        return 4
    }

    var emailValid: Int {
        return 8
    }

    var touristFieldsValid: Int {
        return 16
    }

    init() {
        validState = numberValid | emailValid | touristFieldsValid
    }

    func getValidState() -> Int {
        validState
    }

    func validateTouristFields(_ tourists: [TouristModel], completion: @escaping (Int) -> Void) {
        for (index, tourist) in tourists.enumerated() {
            if tourist.name.count == 0 {
                completion(index)
                continue
            }
            if tourist.lastName.count == 0 {
                completion(index)
                continue
            }
            if tourist.birthDate.count == 0 {
                completion(index)
                continue
            }
            if tourist.nationality.count == 0 {
                completion(index)
                continue
            }

            if tourist.passportCode.count == 0 {
                completion(index)
                continue
            }
            if tourist.passportValidityPeriod.count == 0 {
                completion(index)
                continue
            }
        }
    }

    func validatePhoneAndEmailFields(_ phone: String, _ email: String, comletion: @escaping (Int) -> Void) -> Bool {
        validatePhoneNumber(phone)
        validateEmail(email)
        comletion(validState)
        if validState & (numberValid | emailValid) != (numberValid | emailValid) {
            return false
        }
        return true
    }

    private func validateEmail(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        if emailPred.evaluate(with: email) {
            validState = validState | emailValid
        } else {
            if validState & emailValid != 0 {
                validState = validState ^ emailValid
            }
        }
    }

    private func validatePhoneNumber(_ phone: String) {
        if phone.isEmpty || phone.contains(where: { $0 == "*" }) {
            if validState & numberValid != 0 {
                validState = validState ^ numberValid
            }
        } else {
            if validState & numberValid == 0 {
                validState = validState | numberValid
            }
        }
    }
}
