//
//  BookingSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct BookingSceneView<ViewModel: BookingViewModelProtocol>: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var isDelete = false
    @FocusState var isStartEditingPhone: Bool
    @FocusState var isStartEditingEmail: Bool
    @ObservedObject var viewModel: ViewModel
    @State var prop: Bool = false
    var body: some View {
        VStack {
            if let viewData = self.viewModel.viewData {
                ScrollView {
                    VStack {
                        hotelShortData(viewData: viewData)
                        tourInfo(viewData: viewData)
                        buyerInformation(viewData: viewData)
                        ForEach(0 ..< self.viewModel.tourists.count, id: \.self) { index in
                            self.tourist(viewData: viewData, index: index)
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
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.greyTintColor)
                Text(viewData.getTourPrice())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("Топливный сбор")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getFuelChange())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("Сервисный сбор")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getServiceChange())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.black)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            HStack {
                Text("К оплате")
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light), color: Constants.Colors.greyTintColor)
                Spacer()
                Text(viewData.getSummTour())
                    .fontWithForeground(font: Font(Constants.Fonts.sfpro16Bold), color: Constants.Colors.buttonBlueTint)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - adding tourist view

    @ViewBuilder private func addingTourist() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Добавить туриста")
                    .font(Font(Constants.Fonts.sfpro22Regular))
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

    @ViewBuilder private func tourist(viewData: BookingParseModel, index: Int) -> some View {
        VStack(alignment: .leading) {
            DropDownView(touristStr: viewData.formatter.integerToWord(index), tourist: $viewModel.tourists[index])
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Buyer info

    @ViewBuilder private func buyerInformation(viewData _: BookingParseModel) -> some View {
        VStack(alignment: .leading) {
            Text("Информация о покупателе")
                .fontWithForeground(font: Font(Constants.Fonts.sfpro22Regular), color: Constants.Colors.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            CustTextField(placeholder: "Номер телефона", value: $phoneNumber, keyboardType: .phonePad) { newValue in
                if let newNumber = self.viewModel.formatedPhoneNumber(newValue) {
                    _ = self.viewModel.verifyInputData(phone: newValue, email: email)
                    phoneNumber = newNumber
                }
            }
            .background(self.viewModel.validState.isValidNumber ? Constants.Colors.textFieldBackground :
                Constants.Colors.textFieldWarning)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            CustTextField(placeholder: "Почта", value: $email, keyboardType: .emailAddress) { newValue in
                _ = self.viewModel.verifyInputData(phone: phoneNumber, email: newValue)
            }
            .background(self.viewModel.validState.isValidEmail ? Constants.Colors.textFieldBackground :
                Constants.Colors.textFieldWarning)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            VStack(alignment: .leading) {
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .font(Font(Constants.Fonts.sfpro14Light))
                    .foregroundColor(Constants.Colors.greyTintColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Tour info

    @ViewBuilder private func tourInfo(viewData: BookingParseModel) -> some View {
        VStack {
            HStack {
                Text("Вылет из")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(viewData.departure)
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Страна, город")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(viewData.arrivalCountry)
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Даты")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(viewData.tourStartDate)
                    .foregroundColor(Color.black)
                Text("-")
                    .foregroundColor(Color.black)
                Text(viewData.tourStopDate)
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Кол-во ночей")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(viewData.getCountOfNights())
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Отель")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(String(viewData.hotelName))
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Номер")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(String(viewData.room))
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

            HStack {
                Text("Питание")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150, alignment: .leading)
                Text(String(viewData.nutrition))
                    .foregroundColor(Color.black)

                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .blockStyle(color: Constants.Colors.white)
    }

    // MARK: - Hotel short data

    @ViewBuilder private func hotelShortData(viewData: BookingParseModel) -> some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Constants.Colors.ratingColor)
                            .frame(width: 15, height: 15)
                        Text(viewData.getHotelRating())
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
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                HStack {
                    Text(viewData.hotelName)
                        .font(Font(Constants.Fonts.sfpro22Regular))
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
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .blockStyle(color: Constants.Colors.white)
    }
}
