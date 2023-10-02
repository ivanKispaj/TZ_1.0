//
//  Coordinator.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import SwiftUI

enum Page: Hashable
{
    case hotel
    case rooms(String)
    case booking
    case lastScene
}

class Coordinator: ObservableObject
{
    @Published var path = NavigationPath()
    
    func push(_ page: Page)
    {
        path.append(page)
    }
    
    func pop()
    {
        path.removeLast()
    }
    
    func poptoRoot()
    {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View
    {
        switch page
        {
        case .hotel:
            MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
        case .rooms (let title):
            RoomsSceneView(sceneTitle: title, viewModel: RoomsViewMoedel(service: AlamofierService<RoomsParseModel>()))
        case .booking:
            BookingSceneView(sceneTitle: "Бронирование", viewModel: BookingViewModel(service: AlamofierService<BookingParseModel>()))
        case .lastScene:
            LastScene(title: "Заказ оплачен")
        }
    }
}
