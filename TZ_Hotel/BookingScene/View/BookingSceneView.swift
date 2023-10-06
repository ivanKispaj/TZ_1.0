//
//  BookingSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct BookingSceneView<viewModel: BookingViewModelProtocol>: View
{
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State var phoneNumber: String = ""
    
    @State var email: String = ""
    @State var isDelete = false
    @FocusState var isStartEditingPhone: Bool
    @FocusState var isStartEditingEmail: Bool
    
    @ObservedObject var viewModel: viewModel
    
    var body: some View
    {
        VStack
        {
            if let viewData = self.viewModel.viewData
            {
                   ScrollView
                {
                    VStack
                    {
                        VStack
                        {
                            hotelShortData(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        
                        VStack (alignment: .leading)
                        {
                            tourInfo(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        
                        VStack (alignment: .leading)
                        {
                            buyerInformation(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        
                        ForEach(0..<self.viewModel.tourists.count, id: \.self) { index in
                            VStack(alignment: .leading)
                            {
                                    self.tourist(viewData: viewData, index: index)
                            }
//
                            .background(Constants.Colors.white)
                            .cornerRadius(15)
                           // .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

                        }
                       
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        VStack (alignment: .leading)
                        {
                            addingTourist()
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        
                        VStack (alignment: .leading)
                        {
                            paymentTour(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                    }
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                    .background(Constants.Colors.basicBackground)
                    
                    VStack(spacing: 0)
                    {
                        SelectedButton(buttonText: "Оплатить \(viewData.getSummTour())") {
                            // varyfy fill data and go last scene
                            if self.viewModel.verifyInputData(phone: phoneNumber, email: email)
                            {
                                coordinator.push(.lastScene)
                            }
                        }
                    }
                    .background(Constants.Colors.white)
                    
                }
            } else
            {
                Spacer()
                HStack
                {
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
            HStack
            {
                Text("Тур")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Font(Constants.Fonts.sfpro16Light))
                Spacer()
                Text(viewData.getTourPrice())
                    .foregroundColor(Color.black)
                    .font(Font(Constants.Fonts.sfpro16Light))
                
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Топливный сбор")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Font(Constants.Fonts.sfpro16Light))
                Spacer()
                Text(viewData.getFuelChange())
                    .foregroundColor(Color.black)
                    .font(Font(Constants.Fonts.sfpro16Light))
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Сервисный сбор")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Font(Constants.Fonts.sfpro16Light))
                Spacer()
                Text(viewData.getServiceChange())
                    .foregroundColor(Color.black)
                    .font(Font(Constants.Fonts.sfpro16Light))
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("К оплате")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Font(Constants.Fonts.sfpro16Light))
                Spacer()
                Text(viewData.getSummTour())
                    .foregroundColor(Constants.Colors.buttonBlueTint)
                    .font(Font(Constants.Fonts.sfpro16Bold))
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

    }
    
    
    // MARK: - adding tourist view
    @ViewBuilder private func addingTourist() -> some View {
        
        HStack(spacing: 0)
        {
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
                    .animation(.interactiveSpring)
                    .foregroundColor(Constants.Colors.white)
                
            }
            .frame(width: 32,height: 32)
            .background(Constants.Colors.buttonBlueTint)
            .cornerRadius(6)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    
    // MARK: - Tourist view
    @ViewBuilder private func tourist(viewData: BookingParseModel, index: Int) -> some View {
        VStack(alignment: .leading)
        {
            DropDownView(touristStr: viewData.formatter.integerToWord(index) ,tourist: $viewModel.tourists[index])
            
        }
    }
    
    
    // MARK: - Buyer info
    @ViewBuilder private func buyerInformation(viewData: BookingParseModel) -> some View {
        VStack(alignment: .leading)
        {
            Text("Информация о покупателе")
                .font(Font(Constants.Fonts.sfpro22Regular))
                .foregroundColor(Constants.Colors.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            VStack
            {
                VStack(alignment: .leading,spacing: 0)
                {
                    Text("Номер телефона")
                        .font(Font(Constants.Fonts.callout2))
                        .foregroundColor(Constants.Colors.textFieldPlace)
                    
                    
                    TextField("", text: $phoneNumber)
                        .font(Font(Constants.Fonts.sfpro16Light))
                        .keyboardType(.decimalPad)
                        .focused($isStartEditingPhone)
                        .foregroundColor(Constants.Colors.textFieldForeground)
                        .onChange(of: phoneNumber) { newValue in
                            if let newNumber = self.viewModel.formatedPhoneNumber(newValue)
                            {
                                let _ = self.viewModel.verifyInputData(phone: phoneNumber, email: newValue)
                                phoneNumber = newNumber
                            }
                        }
                        .onTapGesture {
                            phoneNumber = self.viewModel.formatedPhoneNumber(nil) ?? ""
                        }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
            }
            .background(((self.viewModel.validState & self.viewModel.textFieldVAlidator.numberValid) != 0) ? Constants.Colors.textFieldBackground : Constants.Colors.textFieldWarning)
            .background(Constants.Colors.textFieldBackground)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            
            VStack
            {
                VStack(alignment: .leading,spacing: 0)
                {
                    Text("Почта")
                        .font(Font(Constants.Fonts.callout2))
                        .foregroundColor(Constants.Colors.textFieldPlace)
                    TextField("", text: $email)
                        .foregroundColor(Constants.Colors.textFieldForeground)
                        .keyboardType(.emailAddress)
                        .font(Font(Constants.Fonts.sfpro16Light))
                        .focused($isStartEditingPhone)
                        .onChange(of: email) { newValue in
                            let _ = self.viewModel.verifyInputData(phone: phoneNumber, email: newValue)
                        }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
                
            }
            .background(((self.viewModel.validState & self.viewModel.textFieldVAlidator.emailValid) != 0) ? Constants.Colors.textFieldBackground : Constants.Colors.textFieldWarning)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            VStack(alignment: .leading)
            {
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .font(Font(Constants.Fonts.sfpro14Light))
                    .foregroundColor(Constants.Colors.greyTintColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        
        
    }
    
    // MARK: - Tour info
    @ViewBuilder private func tourInfo(viewData: BookingParseModel) -> some View {
        
        VStack
        {
            HStack
            {
                Text("Вылет из")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(viewData.departure)
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Страна, город")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(viewData.arrivalCountry)
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Даты")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
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
            
            
            HStack
            {
                Text("Кол-во ночей")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(viewData.getCountOfNights())
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Отель")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(String(viewData.hotelName))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Номер")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(String(viewData.room))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Питание")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(String(viewData.nutrition))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Font(Constants.Fonts.sfpro16Light))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    // MARK: - Hotel short data
    @ViewBuilder private func hotelShortData(viewData: BookingParseModel) -> some View {
        VStack(spacing: 0)
        {
            VStack
            {
                HStack {
                    HStack(alignment: .center)
                    {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Constants.Colors.ratingColor)
                            .frame(width: 15,height: 15)
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
                
                HStack
                {
                    Text(viewData.hotelName)
                        .font(Font(Constants.Fonts.sfpro22Regular))
                        .foregroundColor(Constants.Colors.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                
                
                HStack
                {
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
    }
    
    
}


