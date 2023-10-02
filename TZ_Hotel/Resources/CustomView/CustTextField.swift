//
//  CustTextField.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 02.10.2023.
//

import SwiftUI

struct CustTextField: View {
    var placeholder: String
    @State var wihtDataPicker: Bool = false
    
    @Binding var isValidData: Bool
    @Binding var value: String
    @State var onTapped: Bool = false
    @State var selectedDate: Date = Date()
    @State var dataPickerShow: Bool = false
    @FocusState var isFocused: Bool
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0)
        {
            HStack
            {
                Text(placeholder)
                    .foregroundColor(Constants.Colors.textFieldPlace)
                    .font(onTapped ? Constants.Fonts.callout2 : Constants.Fonts.playsholder17)
                Spacer()
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            /// Скрыть до нажатия на плейсхолдер
            if onTapped && !wihtDataPicker
            {
                HStack
                {
                    TextField("", text: $value)
                        .foregroundColor(Constants.Colors.textFieldForeground)
                        .font(Constants.Fonts.sfpro16Light)
                        .focused($isFocused)
                    Spacer()
                    
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                
            } else if onTapped && wihtDataPicker
            {
                HStack
                {
                    Text(value)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.black)
                    
                }
                if dataPickerShow && wihtDataPicker
                {
                    HStack
                    {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .foregroundColor(Constants.Colors.black)
                            .environment(\.locale, Locale.init(identifier: "ru-RU"))
                            .datePickerStyle(.wheel)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onChange(of: selectedDate) { newValue in
                                value = dateFormatter.string(from: newValue)
                            }
                            .onTapGesture {
                                dataPickerShow = false
                            }
                            .focused($isFocused)
                    }
                }
            }
        }
        .frame(height: dataPickerShow ? 100 : 52)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(isValidData || (!isValidData && value.count > 0) ? Constants.Colors.textFieldBackground : Constants.Colors.textFieldWarning)
        .cornerRadius(10)
        .onTapGesture {
            onTapped = true
            isFocused.toggle()
            if wihtDataPicker
            {
                dataPickerShow.toggle()
                
            }
        }
    }
}
