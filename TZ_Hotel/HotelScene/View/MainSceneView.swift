//
//  MainSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import SwiftUI

struct MainSceneView<ViewModel: MainViewModelProtocol>: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if let viewData = self.viewModel.viewData {
                ScrollView {
                    VStack {
                        VStack {
                            CarouselImage(item: viewData.imageData)

                            hotelShortData(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Об отеле")
                                    .font(Font(Constants.Fonts.sfpro22Regular))
                                    .foregroundColor(Constants.Colors.black)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                            pecularities(viewData)

                            hotelData(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))

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

    // MARK: - hotelShortData

    @ViewBuilder private func hotelShortData(viewData: HotelPresentModel) -> some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(Constants.Colors.ratingColor)
                    .frame(width: 15, height: 15)
                Text(String(self.viewModel.viewData!.rating))
                    .font(Font(Constants.Fonts.sfpro16Regular))
                    .foregroundColor(Constants.Colors.ratingColor)
                Text(viewData.ratingDescription)
                    .font(Font(Constants.Fonts.sfpro16Regular))
                    .foregroundColor(Constants.Colors.ratingColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(height: 29)
            .background(Constants.Colors.ratingBackground)
            .cornerRadius(5)
            Spacer()
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

        HStack {
            Text(viewData.name)
                .font(Font(Constants.Fonts.sfpro22Regular))
                .foregroundColor(Constants.Colors.black)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))

        HStack {
            Button(viewData.adress) {
                // any action
            }
            .font(Font(Constants.Fonts.sfpro14Regular))
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))

        HStack(alignment: .bottom) {
            Text("от")
                .font(Font(Constants.Fonts.sfpro30Medium))
                .foregroundColor(Constants.Colors.black)
            Text(viewData.getMinPrice())
                .foregroundColor(Constants.Colors.black)
                .font(Font(Constants.Fonts.sfpro30Medium))
            Text(viewData.priceDescription)
                .font(Font(Constants.Fonts.sfpro14Light))
                .foregroundColor(Constants.Colors.greyTintColor)
            Spacer()
        }

        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
    }

    @ViewBuilder private func pecularities(_ viewData: HotelPresentModel) -> some View {
        ForEach(viewData.getPeculiarities(font: Constants.Fonts.sfpro16Regular, padding: 30), id: \.self) { arr in
            HStack(spacing: 0) {
                ForEach(arr, id: \.self) { word in
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
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        }

        VStack {
            Text(viewData.hotelDescription)
                .foregroundColor(Constants.Colors.colorDescription)
                .font(Font(Constants.Fonts.sfpro16Light))
                .multilineTextAlignment(.leading)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }

    // MARK: - HotelData

    @ViewBuilder private func hotelData(viewData _: HotelPresentModel) -> some View {
        VStack(spacing: 0) {
            Button {
                // some action
            } label: {
                HStack(alignment: .center) {
                    Image(Constants.ImagesName.emojiHappy)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading) {
                        Text("Удобства")
                            .font(Font(Constants.Fonts.sfpro16Regular))
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Font(Constants.Fonts.sfpro14Regular))
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .frame(height: 38)
            .padding(10)

            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 65, bottom: 0, trailing: 10))
                .background(Constants.Colors.buttonGrayBackground)

            Button {
                // some action
            } label: {
                HStack(alignment: .center) {
                    Image("tickSquare")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading) {
                        Text("Что включено")
                            .font(Font(Constants.Fonts.sfpro16Regular))
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Font(Constants.Fonts.sfpro14Regular))
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .frame(height: 38)
            .padding(10)

            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 65, bottom: 0, trailing: 20))
                .background(Constants.Colors.buttonGrayBackground)

            Button {
                // some action
            } label: {
                HStack(alignment: .center) {
                    Image("closeSquare")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading) {
                        Text("Что не включено")
                            .font(Font(Constants.Fonts.sfpro16Regular))
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Font(Constants.Fonts.sfpro14Regular))
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .frame(height: 38)
            .padding(10)

            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 65, bottom: 0, trailing: 20))
                .background(Constants.Colors.buttonGrayBackground)
        }

        .background(Constants.Colors.buttonGrayBackground)
        .cornerRadius(15)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
