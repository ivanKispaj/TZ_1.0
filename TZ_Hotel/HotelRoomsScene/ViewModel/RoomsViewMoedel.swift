//
//  RoomsViewMoedel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import UIKit

class RoomsViewMoedel: ObservableObject
{
    @Published var viewData: [RoomsPresentModel] = []
    
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
    
    func moneyPresent(_ index: Int) -> String
    {
        if var money = formater.string(from: NSNumber(value: viewData[index].price))
        {
            money += " " + " \u{20BD}"
            return money
        }
        return ""
    }
    
    func fetchData()
    {
        guard let url = Constants.ApiURL.roomsSceneUrl else {return}
        let group = DispatchGroup()
        
        var roomsPresModel: [RoomsPresentModel] = []
        var roomsImg: [Int :[String]] = [:]
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            group.enter()
            self.service.loadDataToDecodableModel(url: url) { model, error in
                guard error == nil else {return}
                guard let roomsModel = model as? RoomsParseModel else {return}
                for room in roomsModel.rooms
                {
                    let roomModel = RoomsPresentModel(id: room.id,
                                                      name: room.name,
                                                      price: room.price,
                                                      priceDescription: room.priceDescription,
                                                      peculiarties: room.peculiarities,
                                                      imgData: [])
                    roomsPresModel.append(roomModel)
                    
                    if var roomImgArr = roomsImg[room.id]
                    {
                        roomImgArr += room.imgUrl
                        roomsImg[room.id] = roomImgArr
                    } else
                    {
                        roomsImg[room.id] = room.imgUrl
                    }
                    
                }
                group.leave()
                for (key, value) in roomsImg
                {
                    for img in value
                    {
                        group.enter()
                        if let url = URL(string: img)
                        {
                            self.service.loadData(url: url) { respData, _ in
                                if let data = respData, let index = roomsPresModel.firstIndex(where: {$0.id == key})
                                {
                                    if let img = UIImage(data: data)
                                    {
                                        roomsPresModel[index].imgData.append(img)
                                    }
                                    
                                    group.leave()
                                }
                            }
                        }
                    }
                    
                }
                
                group.notify(queue: DispatchQueue.main) { [weak self] in
                    guard let self = self else {return}
                    DispatchQueue.main.async {
                        self.viewData = roomsPresModel
                    }
                }
            }
        }
    }
}
