//
//  AlamofierService.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Alamofire
import Foundation

class AlamofierService<Model: Decodable>: NetworkServiceProtocol {
    
    private var connectionTimeout: Int
    
    init(connectionTimeout: Int) {
        self.connectionTimeout = connectionTimeout
    }
    
    func loadDataToDecodableModel(endpoint: UrlPath, completion: @escaping (Model?, Error?) -> Void) {
        guard let url = endpoint.url else { return }
        AF.request(url, method: endpoint.method,
                        headers: endpoint.headers, requestModifier: {$0.timeoutInterval = 20})
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
        AF.request(url, requestModifier: {$0.timeoutInterval = 20}).response { response in
            if let code = response.response?.statusCode, code >= 400 {
                completion(nil, ConnectError.noConnect)
                return
            }
            guard let data = response.data else {
                completion(nil, ConnectError.noConnect)
                return
            }
            completion(data, nil)
        }
    }
}
