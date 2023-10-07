//
//  MainViewModel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import UIKit

class MainViewModel: MainViewModelProtocol {
    @Published var viewData: HotelPresentModel?

    let networkService: any NetworkServiceProtocol

    init(service: any NetworkServiceProtocol) {
        networkService = service
    }

    func fetchData() {
        let group = DispatchGroup()
        var strUrls: [String]?
        var hotelPresentModel: HotelPresentModel?

        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            group.enter()
            self.networkService.loadDataToDecodableModel(endpoint: .hotel) { model, error in
                guard error == nil else { return }
                guard let parseModel = model as? HotelParseModel else { return }
                strUrls = parseModel.imageUrls
                hotelPresentModel = HotelPresentModel(data: parseModel)
                DispatchQueue.main.async {
                    self.viewData = hotelPresentModel
                }
                if let imgUrls = strUrls {
                    for strUrl in imgUrls {
                        if let url = URL(string: strUrl) {
                            group.enter()
                            self.networkService.loadData(url: url) { respData, _ in
                                if let data = respData, let img = UIImage(data: data) {
                                    hotelPresentModel?.imageData.append(img)
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
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.viewData = hotelPresentModel
            }
        }
    }
}
