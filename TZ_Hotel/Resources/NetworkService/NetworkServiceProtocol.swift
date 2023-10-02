//
//  NetworkServiceProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
// https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3

import Foundation

protocol NetworkServiceProtocol: AnyObject
{
    associatedtype T: Decodable
    func loadDataToDecodableModel(url: URL, completion: @escaping (T?,Error?) -> ())
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> ())
}
