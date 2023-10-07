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
            MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Отель")
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                }
        case let .rooms(title):
            RoomsSceneView(viewModel: RoomsViewModel(service: AlamofierService<RoomsParseModel>()))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 6, height: 12)
                                .foregroundColor(Constants.Colors.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 8))
                        }
                    }
                }
        case .booking:
            BookingSceneView(viewModel: BookingViewModel(service: AlamofierService<BookingParseModel>()))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Бронирование")
                            .font(Font(Constants.Fonts.headline1))
                            .foregroundColor(Constants.Colors.black)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 6, height: 12)
                                .foregroundColor(Constants.Colors.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 8))
                        }
                    }
                }
        case .lastScene:
            LastScene(title: "Заказ оплачен")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Заказ оплачен")
                                .font(Font(Constants.Fonts.headline1))
                                .foregroundColor(Constants.Colors.black)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 6, height: 12)
                                .foregroundColor(Constants.Colors.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 8))
                        }
                    }
                }
        }
    }
}
