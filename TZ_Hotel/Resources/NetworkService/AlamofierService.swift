//
//  AlamofierService.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Alamofire
import Foundation

class AlamofierService<Model: Decodable>: NetworkServiceProtocol {
    func loadDataToDecodableModel(endpoint: UrlPath, completion: @escaping (Model?, Error?) -> Void) {
        guard let url = endpoint.url else { return }
        AF.request(url, method: endpoint.method,
                   headers: endpoint.headers)
            .responseDecodable(of: Model.self) { response in
                if let code = response.response?.statusCode, code >= 400 {
                    completion(nil, ConnectError.noConnect)
                }

                switch response.result {
                case let .success(model):
                    completion(model, nil)
                case .failure:
                    completion(nil, ConnectError.parseError)
                }
            }
    }

    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(url).response { response in
            if let code = response.response?.statusCode, code >= 400 {
                completion(nil, ConnectError.noConnect)
            }
            guard let data = response.data else {
                completion(nil, ConnectError.noConnect)
                return
            }
            completion(data, nil)
        }
    }
}
