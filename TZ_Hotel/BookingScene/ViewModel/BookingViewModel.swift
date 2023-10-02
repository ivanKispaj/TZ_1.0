//
//  BookingViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import Foundation

class BookingViewModel: ObservableObject
{
    @Published var viewData: BookingParseModel?
    @Published var tourists: [TouristModel] = [TouristModel()]
    private let service: any NetworkServiceProtocol
    
    lazy var formater: NumberFormatter =
    {
        let formater = NumberFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.groupingSeparator = " "
        
        return formater
    }()
    
    init(viewData: BookingParseModel? = nil, service: any NetworkServiceProtocol) {
        self.service = service
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
}

