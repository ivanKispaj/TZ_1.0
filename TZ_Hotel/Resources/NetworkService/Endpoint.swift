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

    case hotel = "/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    case rooms = "/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
    case booking = "/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"

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
