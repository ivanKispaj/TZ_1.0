//
//  HotelMainSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import SwiftUI

struct HotelMainSceneView<ViewModel: MainViewModelProtocol>: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if let viewData = self.viewModel.viewData {
                ScrollView {
                    VStack {
                        HotelInfoView(viewData: viewData)
                        HotelDescriptionView(viewData: viewData)
                        VStack {
                            SelectedButton(buttonText: "К выбору номера") {
                                // some action
                                coordinator.push(.rooms(viewData.name))
                            }
                        }
                        .background(Constants.Colors.white)
                    }
                    .background(Constants.Colors.basicBackground)
                }
            } else {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView("Search...")
                        .tint(Constants.Colors.black)
                        .foregroundColor(Constants.Colors.black)
                        .onAppear {
                            if self.viewModel.viewData == nil {
                                self.viewModel.fetchData()
                            }
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Constants.Colors.white)
    }
}

// MARK: - Preview

//
//
// struct MainSceneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
//    }
// }
