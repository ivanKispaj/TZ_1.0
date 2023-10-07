//
//  AlamofierService.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Alamofire
import Foundation

class AlamofierService<T: Decodable>: NetworkServiceProtocol {
    lazy var headers: HTTPHeaders = {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        return headers
    }()

    func loadDataToDecodableModel(url: URL, completion: @escaping (T?, Error?) -> Void) {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        AF.request(url, headers: headers).responseDecodable(of: T.self) { response in
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
