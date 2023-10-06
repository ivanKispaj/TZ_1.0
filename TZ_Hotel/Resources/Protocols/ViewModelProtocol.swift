//
//  ViewModelProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import Foundation

protocol ViewModelProtocol: ObservableObject
{
    var networkService: any NetworkServiceProtocol { get }
    func fetchData()
}
