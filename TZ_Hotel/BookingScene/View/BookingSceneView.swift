//
//  BookingSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct BookingSceneView<ViewModel: BookingViewModelProtocol>: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @FocusState var isStartEditingPhone: Bool
    @FocusState var isStartEditingEmail: Bool
    var body: some View {
        VStack {
            if let viewData = self.viewModel.viewData {
                ScrollView(showsIndicators: false) {
                    VStack {
                        hotelShortData(viewData: viewData)
                        tourInfo(viewData: viewData)
                        buyerInformation(viewData: viewData)
                        ForEach(0 ..< self.viewModel.tourists.count, id: \.self) { index in
                            self.tourist(sectionName: viewData.formatter.integerToWord(index), index: index)
                                .onDelete {
                                    withAnimation(.smooth) {
                                        self.viewModel.removeTourist(index)
                                    }
                                }
                        }
                        addingTourist()
                        paymentTour(viewData: viewData)
                    }
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                    .background(Constants.Colors.basicBackground)
                    VStack(spacing: 0) {
                        SelectedButton(buttonText: "Оплатить \(viewData.getSummTour())") {
                            // varyfy fill data and go last scene
                            if self.viewModel.verifyInputData(phone: phoneNumber, email: email) {
                                coordinator.push(.lastScene)
                            } else {
                                
                            }
                        }
                    }
                    .background(Constants.Colors.white)
                }
            } else {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView("Search...")
                        .tint(Constants.Colors.black)
                        .foregroundColor(Constants.Colors.black)
                        .onAppear {
                            self.viewModel.fetchData()
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Constants.Colors.white)
        .onTapGesture {
            isStartEditingPhone = false
            isStartEditingEmail = false
        }
    }

    // Payment tour
    @ViewBuilder private func paymentTour(viewData: BookingParseModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Тур")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getTourPrice())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("Топливный сбор")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getFuelChange())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("Сервисный сбор")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getServiceChange())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("К оплате")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Regular), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getSummTour())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Semibold), color: Constants.Colors.buttonBlueTint)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - adding tourist view

    @ViewBuilder private func addingTourist() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Добавить туриста")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro22Medium), color: Constants.Colors.black)
                Spacer()
                Button {
                    // adding tourist
                    withAnimation(.easeIn) {
                        self.viewModel.tourists.append(TouristModel())
                    }
                } label: {
                    Image(systemName: "plus")
                        .rotationEffect(.degrees(90))
                        .animation(.bouncy, value: viewModel.tourists)
                        .foregroundColor(Constants.Colors.white)
                }
                .frame(width: 32, height: 32)
                .background(Constants.Colors.buttonBlueTint)
                .cornerRadius(6)
            }
            .frame(height: 48)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Tourist view

    @ViewBuilder private func tourist(sectionName: String, index: Int) -> some View {
        VStack(alignment: .leading) {
            DropDownView(sectionName: sectionName, tourist: $viewModel.tourists[index])
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Buyer info

    @ViewBuilder private func buyerInformation(viewData _: BookingParseModel) -> some View {
        VStack(alignment: .leading) {
            Text("Информация о покупателе")
                .fontWithForeground(font: Font(Constants.Fonts.sfpro22Medium), color: Constants.Colors.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            CustTextField(placeholder: "Номер телефона",
                          value: $phoneNumber,
                          keyboardType: .phonePad,
                          fieldsState: self.$viewModel.validState.isValidNumber,
                          isPlainFields: false) { newValue in
                if let newNumber = self.viewModel.formatedPhoneNumber(newValue) {
                    _ = self.viewModel.verifyInputData(phone: newValue, email: email)
                    phoneNumber = newNumber
                }
            }
            CustTextField(placeholder: "Почта",
                          value: $email,
                          keyboardType: .emailAddress,
                          fieldsState: self.$viewModel.validState.isValidEmail,
                          isPlainFields: false) { newValue in
                _ = self.viewModel.verifyInputData(phone: phoneNumber, email: newValue)
            }

            VStack(alignment: .leading) {
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .font(Font(Constants.Fonts.sfpro14Regular))
                    .foregroundColor(Constants.Colors.greyTintColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Tour info

    @ViewBuilder private func tourInfo(viewData: BookingParseModel) -> some View {
        VStack {
            twoColumnText("Вылет из", textTwo: viewData.departure)
            twoColumnText("Страна, город", textTwo: viewData.arrivalCountry)
            twoColumnText("Даты", textTwo: viewData.tourStartDate + "-" + viewData.tourStopDate)
            twoColumnText("Кол-во ночей", textTwo: viewData.getCountOfNights())
            twoColumnText("Отель", textTwo: viewData.hotelName)
            twoColumnText("Номер", textTwo: viewData.room)
            twoColumnText("Питание", textTwo: viewData.nutrition)
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Hotel short data

    @ViewBuilder private func hotelShortData(viewData: BookingParseModel) -> some View {
        VStack(spacing: 0) {
            RatingView(text: viewData.getHotelRating() + " " + viewData.ratingDescription)

            HStack {
                Text(viewData.hotelName)
                    .font(Font(Constants.Fonts.sfpro22Medium))
                    .foregroundColor(Constants.Colors.black)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Button(viewData.hotelAdress) {
                    // any action
                }
                .font(Font(Constants.Fonts.sfpro14Regular))
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - twoColumnText

    @ViewBuilder private func twoColumnText(_ textFirst: String, textTwo: String) -> some View {
        HStack {
            Text(textFirst)
                .foregroundColor(Constants.Colors.greyTintColor)
                .frame(width: 150, alignment: .leading)
            Text(textTwo)
                .foregroundColor(Color.black)

            Spacer()
        }
        .font(Font(Constants.Fonts.sfpro16Regular))
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}
