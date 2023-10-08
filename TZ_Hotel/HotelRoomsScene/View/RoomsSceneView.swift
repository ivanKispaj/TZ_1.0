//
//  RoomsSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import SwiftUI
import UIKit

struct RoomsSceneView<ViewModel: RoomsViewModelProtocol>: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel

    @State private var selectedIndex: Int?

    @State private var index: [Int] = [0, 0]

    var body: some View {
        VStack {
            if self.viewModel.viewData.count > 0 {
                let data = self.viewModel.viewData
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0 ..< data.count, id: \.self) { modelIndex in

                            VStack() {
                                VStack(alignment: .leading, spacing: 5) {
                                    RoomsSingleView(viewData: self.$viewModel.viewData[modelIndex])
                                    SelectedButton(buttonText: "Выбрать номер", action: {
                                        coordinator.push(.booking)
                                    })
                                }
                                .blockStyle(color: Constants.Colors.white)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                            }
                            .background(Constants.Colors.basicBackground)
                        }
                        HStack {
                            Spacer()
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                        }
                        .background(Constants.Colors.basicBackground)
                        .frame(height: 8)
                    }
                }

            } else {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView("Search...")
                        .tint(Constants.Colors.black)
                        .foregroundColor(Constants.Colors.black)
                        .onAppear {
                            if self.viewModel.viewData.count == 0 {
                                self.viewModel.fetchData()
                            }
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .onBackSwipe(perform: {
            coordinator.pop()
        })
        .background(Constants.Colors.white)
    }
}

// MARK: - Preview

// struct RoomsSceneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
//    }
// }
