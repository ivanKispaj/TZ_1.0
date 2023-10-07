//
//  RoomsViewModelProtocol.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import SwiftUI

protocol RoomsViewModelProtocol: ObservableObject, ViewModelProtocol {
    var viewData: [RoomsPresentModel] { get set }
}
