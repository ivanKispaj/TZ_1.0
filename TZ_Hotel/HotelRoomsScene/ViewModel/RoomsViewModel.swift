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
        guard let url = Constants.ApiURL.roomsSceneUrl else { return }
        let group = DispatchGroup()
        var roomsPresModel: [RoomsPresentModel] = []
        var roomsImg: [Int: [String]] = [:]
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            group.enter()
            print("start group enter")
            self.networkService.loadDataToDecodableModel(url: url) { model, error in
                guard error == nil else { return }
                guard let roomsModel = model as? RoomsParseModel else { return }
                for (index, room) in roomsModel.rooms.enumerated() {
                    roomsPresModel.append(RoomsPresentModel(data: room))
                    roomsImg[index] = room.imgUrl
                }
                DispatchQueue.main.async {
                    self.viewData = roomsPresModel
                }
                for (key, value) in roomsImg {
                    for img in value {
                        if let url = URL(string: img) {
                            group.enter()
                            print("img enter")
                            self.networkService.loadData(url: url) { data, _ in
                                if let data = data, let img = UIImage(data: data) {
                                    roomsPresModel[key].imgData.append(img)
                                }
                                group.leave()
                                print("img leave")
                            }
                        }
                    }
                }
                print("stop group leave")
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
