//
//  TextFieldValidator.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import Foundation

class TextFieldValidator {
    init() {}

    func validateTouristFields(_ tourists: [TouristModel], completion: @escaping (Int?, Bool) -> Void) {
        var state = true
        for (index, tourist) in tourists.enumerated() {
            if tourist.name.count == 0 {
                state = false
                completion(index, state)
                continue
            }
            if tourist.lastName.count == 0 {
                state = false
                completion(index, state)
                continue
            }
            if tourist.birthDate.count == 0 {
                state = false
                completion(index, state)
                continue
            }
            if tourist.nationality.count == 0 {
                state = false
                completion(index, state)
                continue
            }

            if tourist.passportCode.count == 0 {
                state = false
                completion(index, state)
                continue
            }
            if tourist.passportValidityPeriod.count == 0 {
                state = false
                completion(index, state)
                continue
            }
            completion(index, state)
        }
    }

    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        if emailPred.evaluate(with: email) {
            return true
        }
        return false
    }

    func validatePhoneNumber(_ phone: String) -> Bool {
        if phone.isEmpty || phone.contains(where: { $0 == "*" }) {
            return false
        }
        return true
    }
}
