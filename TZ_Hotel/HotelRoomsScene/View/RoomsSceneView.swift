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
                            Group {
                                VStack(alignment: .leading, spacing: 0) {
                                    CarouselImage(item: data[modelIndex].imgData)
                                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))

                                    Text(data[modelIndex].name)
                                        .font(Font(Constants.Fonts.sfpro22Regular))
                                        .foregroundColor(Constants.Colors.black)
                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))

                                    VStack(alignment: .leading) {
                                        peculiartiesView(data[modelIndex].getPeculiarities(font: Constants.Fonts.sfpro16Regular, padding: 30))
                                    }

                                    buttonInfo()

                                    HStack(alignment: .bottom) {
                                        Text(data[modelIndex].getPrice())
                                            .font(Font(Constants.Fonts.sfpro30Medium))
                                            .foregroundColor(Constants.Colors.black)
                                        Text(data[modelIndex].priceDescription)
                                            .font(Font(Constants.Fonts.sfpro14Light))
                                            .foregroundColor(Constants.Colors.greyTintColor)
                                            .padding(5)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

                                    SelectedButton(buttonText: "Выбрать номер", action: {
                                        coordinator.push(.booking)
                                    })
                                }
                                .background(Constants.Colors.white)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                                .cornerRadius(12)
                            }
                        }
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
                            if self.viewModel.viewData.count == 0 {
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

    // MARK: - button info

    @ViewBuilder private func buttonInfo() -> some View {
        VStack {
            Button {
                // Some Action
            } label: {
                HStack(alignment: .center) {
                    Text("Подробнее о номере")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                }
            }
            .frame(height: 29)
            .background(Constants.Colors.buttonBackGRopac10)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }

    @ViewBuilder private func peculiartiesView(_ data: [[String]]) -> some View {
        ForEach(data, id: \.self) { arr in
            HStack(spacing: 0) {
                peculiartiesData(arr)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

@ViewBuilder private func peculiartiesData(_ data: [String]) -> some View {
    ForEach(data, id: \.self) { word in
        Text(word)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .font(Font(Constants.Fonts.sfpro16Regular))
            .background(Constants.Colors.backGroundPeculiarities)
            .foregroundColor(Constants.Colors.greyTintColor)
            .cornerRadius(5)
        Spacer()
            .frame(width: 5, alignment: .leading)
    }
}

// MARK: - Preview

// struct RoomsSceneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
//    }
// }
