//
//  BookingSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct BookingSceneView: View
{
    
    enum TextFieldStatus: Int
    {
        case none = 2
        case numberValid = 4
        case emailValid = 8
        case touristFieldValid = 16
    }
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State var validState: Int  = TextFieldStatus.numberValid.rawValue | TextFieldStatus.emailValid.rawValue | TextFieldStatus.touristFieldValid.rawValue
    
    
    @State var phoneNumber: String = ""
    private var phoneMask: String = "+7(***)***-**-**"
    
    @State var email: String = ""
    
    @State private var tempInputField: String = ""
    @FocusState var isStartEditingPhone: Bool
    @FocusState var isStartEditingEmail: Bool
    let sceneTitle: String
    
    @ObservedObject var viewModel: BookingViewModel
    
    init(sceneTitle: String, viewModel: BookingViewModel)
    {
        self.sceneTitle = sceneTitle
        self.viewModel = viewModel
    }
    
    var body: some View
    {
        VStack
        {
            if let viewData = viewModel.viewData
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
                        
                        ForEach(0..<viewModel.tourists.count, id: \.self) { index in
                            VStack(alignment: .leading)
                            {
                                self.tourist(viewData: viewData, index: index)
                            }
                            .background(Constants.Colors.white)
                            .cornerRadius(15)
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
                        SelectedButton(buttonText: "Оплатить \(viewModel.summForTourPresent())") {
                            // varyfy fill data and go last scene
                            if verifyInputData()
                            {
                                coordinator.push(.lastScene)
                            } else
                            {
                                
                            }
                        }
                    }
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
                            viewModel.fetchData()
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Constants.Colors.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack{
                    Text(sceneTitle)
                        .font(Constants.Fonts.headline1)
                        .foregroundColor(Constants.Colors.black)
                }
            }
        }
        .onTapGesture {
            isStartEditingPhone = false
            isStartEditingEmail = false
        }
        
        
    }
    
    private func verifyInputData() -> Bool
    {
        if tempInputField.count != 10
        {
            if validState & TextFieldStatus.numberValid.rawValue != 0
            {
                validState = validState ^ TextFieldStatus.numberValid.rawValue
            }
            
            if !isValidEmail(email)
            {
                validState = 0
            } else
            {
                validState = TextFieldStatus.emailValid.rawValue
            }
            return false
        } else if !isValidEmail(email)
        {
            validState = TextFieldStatus.numberValid.rawValue
            return false
        }
        validState = TextFieldStatus.emailValid.rawValue | TextFieldStatus.numberValid.rawValue
        
        var isValidate  = true
        
        for (index, tourist) in viewModel.tourists.enumerated() {
            if tourist.name.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.lastName.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.birthDate.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.nationality.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
            
            if tourist.passportCode.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
            if tourist.passportValidityPeriod.count == 0
            {
                viewModel.tourists[index].isValidData = false
                isValidate = false
                continue
            }
        }
        
        return isValidate
    }
    
    
    // Payment tour
    @ViewBuilder private func paymentTour(viewData: BookingParseModel) -> some View {
        VStack(alignment: .leading) {
            HStack
            {
                Text("Тур")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Constants.Fonts.sfpro16Light)
                Spacer()
                Text(viewModel.moneyPresent(viewData.tourPrice))
                    .foregroundColor(Color.black)
                    .font(Constants.Fonts.sfpro16Light)
                
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Топливный сбор")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Constants.Fonts.sfpro16Light)
                Spacer()
                Text(viewModel.moneyPresent(viewData.fuelChange))
                    .foregroundColor(Color.black)
                    .font(Constants.Fonts.sfpro16Light)
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("Сервисный сбор")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Constants.Fonts.sfpro16Light)
                Spacer()
                Text(viewModel.moneyPresent(viewData.serviceChange))
                    .foregroundColor(Color.black)
                    .font(Constants.Fonts.sfpro16Light)
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            HStack
            {
                Text("К оплате")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Constants.Fonts.sfpro16Light)
                Spacer()
                Text(viewModel.summForTourPresent())
                    .foregroundColor(Constants.Colors.buttonBlueTint)
                    .font(Constants.Fonts.sfpro16Bold)
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    
    // MARK: - adding tourist view
    @ViewBuilder private func addingTourist() -> some View {
        
        HStack
        {
            Text("Добавить туриста")
                .font((Constants.Fonts.sfpro22Regular))
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            Spacer()
            Button {
                // adding tourist
                viewModel.tourists.append(TouristModel())
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(Constants.Colors.white)
                
            }
            .frame(width: 32,height: 32)
            .background(Constants.Colors.buttonBlueTint)
            .cornerRadius(6)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    
    // MARK: - Tourist view
    @ViewBuilder private func tourist(viewData: BookingParseModel, index: Int) -> some View {
        VStack(alignment: .leading)
        {
            DropDownView(touristStr: viewModel.integerToWord(index + 1),tourist: $viewModel.tourists[index])
            
        }
    }
    
    
    // MARK: - Buyer info
    @ViewBuilder private func buyerInformation(viewData: BookingParseModel) -> some View {
        VStack(alignment: .leading)
        {
            Text("Информация о покупателе")
                .font(Constants.Fonts.sfpro22Regular)
                .foregroundColor(Constants.Colors.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            VStack
            {
                VStack(alignment: .leading,spacing: 0)
                {
                    Text("Номер телефона")
                        .font(Constants.Fonts.callout2)
                        .foregroundColor(Constants.Colors.textFieldPlace)
                    
                    
                    TextField("", text: $phoneNumber)
                        .font(Constants.Fonts.sfpro16Light)
                        .keyboardType(.decimalPad)
                        .focused($isStartEditingPhone)
                        .foregroundColor(Constants.Colors.textFieldForeground)
                        .onChange(of: phoneNumber) { newValue in
                            
                            if (newValue.count > phoneMask.count)
                            {
                                if (tempInputField.count < 10)
                                {
                                    var new = newValue
                                    let val = new.removeLast()
                                    if val.isNumber
                                    {
                                        tempInputField.append(val)
                                    }
                                    
                                }
                                
                            } else if newValue.count == phoneMask.count
                            {
                                
                            } else
                            {
                                if(tempInputField.count > 0)
                                {
                                    tempInputField.removeLast()
                                    
                                }
                            }
                            if let newStr = formattesPhone(str: tempInputField)
                            {
                                phoneNumber = newStr
                            }
                            if tempInputField.count == 10
                            {
                                validState = validState | TextFieldStatus.numberValid.rawValue
                            }
                        }
                        .onTapGesture {
                            phoneNumber = phoneMask
                        }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
            }
            .background(((validState & TextFieldStatus.numberValid.rawValue) != 0) ? Constants.Colors.textFieldBackground : Constants.Colors.textFieldWarning)
            .background(Constants.Colors.textFieldBackground)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            
            VStack
            {
                VStack(alignment: .leading,spacing: 0)
                {
                    Text("Почта")
                        .font(Constants.Fonts.callout2)
                        .foregroundColor(Constants.Colors.textFieldPlace)
                    TextField("", text: $email)
                        .foregroundColor(Constants.Colors.textFieldForeground)
                        .keyboardType(.emailAddress)
                        .font(Constants.Fonts.sfpro16Light)
                        .focused($isStartEditingPhone)
                        .onChange(of: email) { newValue in
                            if isValidEmail(newValue)
                            {
                                validState = validState | TextFieldStatus.emailValid.rawValue
                            }
                            if tempInputField.count != 10
                            {
                                if validState & TextFieldStatus.numberValid.rawValue != 0
                                {
                                    validState = validState ^ TextFieldStatus.numberValid.rawValue
                                }
                            }
                        }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
                
            }
            .background(((validState & TextFieldStatus.emailValid.rawValue) != 0) ? Constants.Colors.textFieldBackground : Constants.Colors.textFieldWarning)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            VStack(alignment: .leading)
            {
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .font(Constants.Fonts.sfpro14Light)
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
            .font(Constants.Fonts.sfpro16Light)
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
            .font(Constants.Fonts.sfpro16Light)
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
            .font(Constants.Fonts.sfpro16Light)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            
            HStack
            {
                Text("Кол-во ночей")
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .frame(width: 150,alignment: .leading)
                Text(String(viewData.countOfNights))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .font(Constants.Fonts.sfpro16Light)
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
            .font(Constants.Fonts.sfpro16Light)
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
            .font(Constants.Fonts.sfpro16Light)
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
            .font(Constants.Fonts.sfpro16Light)
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
                            .foregroundColor(Constants.Colors.ratingColor)
                            .frame(width: 15,height: 15)
                        Text(String(viewData.hotelRating))
                            .font(Constants.Fonts.sfpro16Regular)
                            .foregroundColor(Constants.Colors.ratingColor)
                        Text(viewData.ratingDescription)
                            .font(Constants.Fonts.sfpro16Regular)
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
                        .font(Constants.Fonts.sfpro22Regular)
                        .foregroundColor(Constants.Colors.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                
                
                HStack
                {
                    Button(viewData.hotelAdress) {
                        // any action
                    }
                    .font(Constants.Fonts.sfpro14Regular)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            
            
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        if email.count < 5
        {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func formattesPhone(str: String?) -> String? {
        guard let number = str else { return nil }
        let mask = phoneMask
        var result = ""
        var index = number.startIndex
        for ch in mask where index < mask.endIndex {
            if ch == "*" {
                if number.indices.contains(index)
                {
                    result.append(number[index])
                    index = number.index(after: index)
                } else
                {
                    result.append(ch)
                }
            } else {
                result.append(ch)
            }
        }
        return result
    }
}


struct BookingSceneView_Previews: PreviewProvider {
    static var previews: some View {
        BookingSceneView(sceneTitle: "Test", viewModel: BookingViewModel(service: AlamofierService<BookingParseModel>()))
    }
}
