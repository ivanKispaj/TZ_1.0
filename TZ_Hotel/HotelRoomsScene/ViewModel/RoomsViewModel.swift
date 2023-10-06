//
//  RoomsViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import UIKit

class RoomsViewModel: RoomsViewModelProtocol
{
    @Published var viewData: [RoomsPresentModel] = []
    
    internal let networkService: any NetworkServiceProtocol
    
    init(service: any NetworkServiceProtocol)
    {
        self.networkService = service
    }
    
    func fetchData()
    {
        guard let url = Constants.ApiURL.roomsSceneUrl else {return}
        let group = DispatchGroup()
        
        var roomsPresModel: [RoomsPresentModel] = []
        var roomsImg: [Int :[String]] = [:]
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            group.enter()
            self.networkService.loadDataToDecodableModel(url: url) { model, error in
                guard error == nil else {return}
                guard let roomsModel = model as? RoomsParseModel else {return}
                for room in roomsModel.rooms
                {
                    let roomModel = RoomsPresentModel(data: room)
                    roomsPresModel.append(roomModel)
                    DispatchQueue.main.async {
                        self.viewData = roomsPresModel
                    }
                    
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
                            self.networkService.loadData(url: url) { respData, _ in
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
