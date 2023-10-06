//
//  MainViewModelProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import SwiftUI

protocol MainViewModelProtocol: ObservableObject, ViewModelProtocol
{
    var viewData: HotelPresentModel? { get set }
}
