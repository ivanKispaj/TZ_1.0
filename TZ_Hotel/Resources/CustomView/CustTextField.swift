//
//  CustTextField.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 02.10.2023.
//

import SwiftUI

struct CustTextField: View {
    var placeholder: String
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var wihtDataPicker: Bool = false
    @State var onTapped: Bool = false
    @State var dataPickerShow: Bool = false
    var changed: (String) -> Void = { _ in }
    @State var selectedDate: Date = .init()
    @FocusState var isFocused: Bool

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(placeholder)
                    .fontWithForeground(font: onTapped ?
                        Font(Constants.Fonts.callout2) :
                        Font(Constants.Fonts.playsholder17),
                        color: Constants.Colors.textFieldPlace)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            /// Скрыть до нажатия на плейсхолдер
            if onTapped && !wihtDataPicker {
                HStack {
                    TextField("", text: $value)
                        .fontWithForeground(font: Font(Constants.Fonts.sfpro16Light),
                                            color: Constants.Colors.textFieldForeground)
                        .focused($isFocused)
                        .onSubmit {
                            if value.isEmpty {
                                onTapped.toggle()
                            }
                        }
                        .keyboardType(keyboardType)
                        .onChange(of: value) { newValue in
                            changed(newValue)
                        }

                    Spacer()
                }

                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))

            } else if onTapped && wihtDataPicker {
                HStack {
                    Text(value)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.black)
                }
                if dataPickerShow && wihtDataPicker {
                    HStack {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .colorMultiply(Constants.Colors.textFieldForeground)
                            .environment(\.locale, Locale(identifier: "ru-RU"))
                            .datePickerStyle(.wheel)
                            .background(Constants.Colors.textFieldBackground)
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
        .cornerRadius(10)
        .onTapGesture {
            onTapped = true
            isFocused.toggle()
            if wihtDataPicker {
                dataPickerShow.toggle()
            }
        }
    }
}
