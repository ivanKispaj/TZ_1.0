//
//  Coordinator.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import SwiftUI

enum Page: Hashable {
    case hotel
    case rooms(String)
    case booking
    case lastScene
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    let timeoutNetworkForNetworkConnection = 20
    
    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func poptoRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .hotel:
            HotelMainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>(connectionTimeout: timeoutNetworkForNetworkConnection)))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Отель")
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                }
        case let .rooms(title):
            RoomsSceneView(viewModel: RoomsViewModel(service: AlamofierService<RoomsParseModel>(connectionTimeout: timeoutNetworkForNetworkConnection)))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                }
        case .booking:
            BookingSceneView(viewModel: BookingViewModel(service: AlamofierService<BookingParseModel>(connectionTimeout: timeoutNetworkForNetworkConnection)))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Бронирование")
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                }
        case .lastScene:
            LastScene()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Заказ оплачен")
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                }
        }
    }
}
