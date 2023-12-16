//
//  RoomsViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import UIKit

class RoomsViewModel: RoomsViewModelProtocol {
    @Published var viewData: [RoomsPresentModel] = []
    let networkService: any NetworkServiceProtocol
    init(service: any NetworkServiceProtocol) {
        networkService = service
    }

    func fetchData() {
        let group = DispatchGroup()
        var roomsPresModel: [RoomsPresentModel] = []
        var roomsImg: [Int: [String]] = [:]
        group.enter()
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
         
            self.networkService.loadDataToDecodableModel(endpoint: .rooms) { model, error in
                guard error == nil else { return }
                guard let roomsModel = model as? RoomsParseModel else { return }
                for (index, room) in roomsModel.rooms.enumerated() {
                    roomsPresModel.append(RoomsPresentModel(data: room))
                    roomsImg[index] = room.imgUrl
                }
                
                for (key, value) in roomsImg {
                    for img in value {
                        if let url = URL(string: img) {
                            self.networkService.loadData(url: url) { data, error in
                                if let data = data, let img = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        self.viewData[key].imgData.append(img)
                                    }
                                }
                            }
                        }
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewData = roomsPresModel
            }
        }
    }
}
