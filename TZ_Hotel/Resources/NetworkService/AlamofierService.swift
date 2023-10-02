//
//  AlamofierService.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation
import Alamofire

class AlamofierService<T: Decodable>: NetworkServiceProtocol
{
    lazy var headers: HTTPHeaders =
    {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        return headers
    }()
    
    func loadDataToDecodableModel(url: URL, completion: @escaping (T?, Error?) -> ()) {
        var headers: HTTPHeaders = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        AF.request(url, headers: headers).responseDecodable(of: T.self) { response in
            if let code = response.response?.statusCode, code >= 400
            {
                completion(nil, ConnectError.noConnect)
            }
            
            switch response.result {
            case .success(let model):
                completion(model,nil)
            case .failure(_):
                completion(nil,ConnectError.parseError)
            }
            
        }
    }
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> ())
    {
        AF.request(url).response { response in
            if let code = response.response?.statusCode, code >= 400
            {
                completion(nil, ConnectError.noConnect)
            }
            guard let data = response.data else
            {
                completion(nil, ConnectError.noConnect)
                return
            }
            completion(data,nil)
        }
    }
}
