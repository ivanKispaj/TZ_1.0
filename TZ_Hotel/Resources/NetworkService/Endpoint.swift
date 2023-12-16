//
//  Endpoint.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 07.10.2023.
//

import Alamofire
import Foundation

enum UrlPath: String {
    struct Endpoint {
        let path: String
        let queryItems: [URLQueryItem]
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = Constants.apiHost
            components.path = path
            components.queryItems = queryItems
            return components.url
        }
    }

    case hotel = "/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    case rooms = "/v3/8b532701-709e-4194-a41c-1a903af00195"
    case booking = "/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"

    var url: URL? {
        let endpoint = Endpoint(path: rawValue, queryItems: [])
        return endpoint.url
    }

    var method: HTTPMethod {
        return HTTPMethod(rawValue: "GET")
    }

    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        return headers
    }
}
