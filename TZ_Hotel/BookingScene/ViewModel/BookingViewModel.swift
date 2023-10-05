//
//  BookingViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

class BookingViewModel: ObservableObject
{
    enum TextFieldStatus: Int
    {
        case none = 2
        case numberValid = 4
        case emailValid = 8
        case touristFieldValid = 16
    }
    
    @Published var viewData: BookingParseModel?
    @Published var tourists: [TouristModel] = [TouristModel()]
    @Published var validState: Int  = TextFieldStatus.numberValid.rawValue | TextFieldStatus.emailValid.rawValue | TextFieldStatus.touristFieldValid.rawValue
    
    private let service: any NetworkServiceProtocol
    
    lazy var formater: NumberFormatter =
    {
        let formater = NumberFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.groupingSeparator = " "
        
        return formater
    }()
    
    let phoneMask: String = "+7(***)***-**-**"
    var phonePresent: String = ""
    private var inputNumber: String = ""
    
    init(viewData: BookingParseModel? = nil, service: any NetworkServiceProtocol) {
        self.service = service
        phonePresent = phoneMask
    }
    
    func integerToWord(_ index: Int) -> String
    {
        formater.numberStyle = .spellOut
        if let ret = formater.string(from: NSNumber(value: index))
        {
            return ret
        }
        return ""
    }
    
    func summForTourPresent() -> String
    {
        formater.numberStyle = .decimal
        
        if let data = viewData
        {
            let summ = data.tourPrice + data.fuelChange + data.serviceChange
            if var money = formater.string(from: NSNumber(value: summ))
            {
                money += " " + "\u{20BD}"
                return money
            }
        }
        return ""
    }
    func moneyPresent(_ num: Int) -> String
    {
        formater.numberStyle = .decimal
        
        if var money = formater.string(from: NSNumber(value: num))
        {
            money += " " + "\u{20BD}"
            return money
        }
        return ""
    }
    
    func fetchData()
    {
        guard let url = Constants.ApiURL.bookingSceneUrl else {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.service.loadDataToDecodableModel(url: url) { response, error in
                guard error == nil else {return}
                guard let booking = response as? BookingParseModel else {return}
                DispatchQueue.main.async {
                    self.viewData = booking
                }
            }
        }
    }
    func verifyInputData(phone: String, email: String) -> Bool
    {
        validPhoneNumber()
        isValidEmail(email)
        
        if validState & (TextFieldStatus.numberValid.rawValue | TextFieldStatus .emailValid.rawValue)  != (TextFieldStatus.numberValid.rawValue | TextFieldStatus .emailValid.rawValue)
        {
            return false
        }
        
        var isValidate  = true
        
        for (index, tourist) in tourists.enumerated() {
            if tourist.name.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.lastName.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.birthDate.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.nationality.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
            
            if tourist.passportCode.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.passportValidityPeriod.count == 0
            {
                tourists[index].isValidData = false
                isValidate = false
                continue
            }
        }
        
        return isValidate
    }
    
    func validPhoneNumber()
    {
        if inputNumber.count != 10
        {
            if validState & TextFieldStatus.numberValid.rawValue != 0
            {
                validState = validState ^ TextFieldStatus.numberValid.rawValue
            }
        } else
        {
            if validState & TextFieldStatus.numberValid.rawValue == 0
            {
                validState = validState | TextFieldStatus.numberValid.rawValue
            }
        }
        
    }
    
    func isValidEmail(_ email: String) {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email)
        {
            validState = validState | TextFieldStatus.emailValid.rawValue
        } else
        {
            if validState & TextFieldStatus.emailValid.rawValue != 0
            {
                validState = validState ^ TextFieldStatus.emailValid.rawValue
            }
        }
    }
    
    
    func formattesPhone(value: String?) -> String?
    {
        guard var number = value else { return nil}
        
        if (number.count > phoneMask.count)
        {
            if (inputNumber.count < 10)
            {
                let val = number.removeLast()
                if val.isNumber
                {
                    inputNumber.append(val)
                    validPhoneNumber()
                }
                
            }
            
        } else if number.count < phoneMask.count
        {
            if(inputNumber.count > 0)
            {
                inputNumber.removeLast()
                
            }
        } else
        {
            return nil
        }
        
        let mask = phoneMask
        var result = ""
        var index = inputNumber.startIndex
        for ch in mask where index < mask.endIndex {
            if ch == "*" {
                if inputNumber.indices.contains(index)
                {
                    result.append(inputNumber[index])
                    index = number.index(after: index)
                } else
                {
                    result.append(ch)
                }
            } else {
                result.append(ch)
            }
        }
        phonePresent = result
        return result
    }
    
}

