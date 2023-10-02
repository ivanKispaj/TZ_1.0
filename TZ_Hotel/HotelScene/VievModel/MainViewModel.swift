//
//  MainViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import UIKit

class MainViewModel: ObservableObject
{
    @Published var viewData: HotelPresentModel?
    private let service: any NetworkServiceProtocol
    
    lazy var formater: NumberFormatter =
    {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.locale = Locale.current
        formater.groupingSeparator = " "
        
        return formater
    }()
    
    init(service: any NetworkServiceProtocol)
    {
        self.service = service
    }
    
    func moneyPresent(_ num: Int) -> String
    {
        if var money = formater.string(from: NSNumber(value: num))
        {
            money += " " + " \u{20BD}"
            return money
        }
        return ""
    }
    
    func fetchData()
    {
        guard let url = Constants.ApiURL.hotelSceneUrl else {return}
        
        let group = DispatchGroup()
        var strUrls: [String]?
        var hotelViewModel: HotelPresentModel?
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            group.enter()
            self.service.loadDataToDecodableModel(url: url) { model, error in
                guard error == nil else {return}
                guard let hotelModel = model as? HotelParseModel else {return}
                strUrls = hotelModel.imageUrls
                hotelViewModel = HotelPresentModel(id: hotelModel.id,
                                                   name: hotelModel.name,
                                                   adress: hotelModel.adress,
                                                   minPrice: hotelModel.minPrice,
                                                   priceDescription: hotelModel.priceDescription,
                                                   rating: hotelModel.rating,
                                                   ratingDescription: hotelModel.ratingDescription,
                                                   imageData: [],
                                                   hotelDescription: hotelModel.aboutTheHotel.hotelDescription,
                                                   peculiarities: hotelModel.aboutTheHotel.peculiarities)
                if let imgUrls = strUrls
                {
                    for strUrl in imgUrls
                    {
                        if let url = URL(string: strUrl)
                        {
                            group.enter()
                            self.service.loadData(url: url) { respData, _ in
                                if let data = respData, let img = UIImage(data: data) {
                                    hotelViewModel?.imageData.append(img)
                                    group.leave()
                                }
                            }
                        }
                        
                    }
                }
                group.leave()
            }
            
            
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.viewData = hotelViewModel
            }
        }
        
        
        
    }
}
