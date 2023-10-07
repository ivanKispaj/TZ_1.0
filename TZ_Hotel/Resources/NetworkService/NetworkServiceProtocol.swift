//
//  NetworkServiceProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
// https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    associatedtype Model: Decodable
    func loadDataToDecodableModel(endpoint: UrlPath, completion: @escaping (Model?, Error?) -> Void)
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}
