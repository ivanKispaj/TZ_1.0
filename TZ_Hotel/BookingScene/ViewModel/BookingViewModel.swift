//
//  BookingViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

class BookingViewModel: BookingViewModelProtocol
{
    @Published var viewData: BookingParseModel?
    @Published var tourists: [TouristModel] = [TouristModel()]
    @Published var validState: Int
    
    internal let networkService: any NetworkServiceProtocol
    
    let textFieldVAlidator: TextFieldValidator
    
    init(viewData: BookingParseModel? = nil, service: any NetworkServiceProtocol) {
        self.networkService = service
        textFieldVAlidator = TextFieldValidator()
        validState = textFieldVAlidator.getValidState()
    }
    
    func fetchData()
    {
        guard let url = Constants.ApiURL.bookingSceneUrl else {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.networkService.loadDataToDecodableModel(url: url) { response, error in
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
        
        if  !textFieldVAlidator.validatePhoneAndEmailFields(phone, email, comletion: {[weak self] state in
            guard let self = self else {return}
            self.validState = state
        }){
            return false
        }
        
        var isValidate  = true
        
        textFieldVAlidator.validateTouristFields(self.tourists) { [weak self] index in
            guard let self = self else { return }
            self.tourists[index].isValidData = false
            isValidate = false
        }
        return isValidate
    }
    
    func formatedPhoneNumber(_ value: String?) -> String?
    {
        guard let formatter = viewData?.formatter else { return "" }
        
        return formatter.formattesPhone(value: value)
    }
    
}

