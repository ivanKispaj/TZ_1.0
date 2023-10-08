//
//  DropDownView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct DropDownView: View {
    let sectionName: String
    @Binding var tourist: TouristModel
    @State var isDrop: Bool = false
    var body: some View {
        HStack {
            Text("\(sectionName) турист")
                .fontWithForeground(font: Font(Constants.Fonts.sfpro22Regular), color: Constants.Colors.black)
            Spacer()
            Button {
                // drop menu
                withAnimation {
                    isDrop.toggle()
                }

            } label: {
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isDrop ? 0 : 180))
                    .animation(.easeInOut, value: isDrop)
                    .foregroundColor(Constants.Colors.buttonBlueTint)
            }
            .frame(width: 32, height: 32)
            .background(Constants.Colors.buttonBackGRopac10)
            .cornerRadius(6)
        }
        .frame(height: 48)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

        if isDrop {
            VStack {
                CustTextField(placeholder: "Имя",
                              value: $tourist.name,
                              keyboardType: .twitter,
                              fieldsState: $tourist.isValidData)

                CustTextField(placeholder: "Фамилия",
                              value: $tourist.lastName,
                              keyboardType: .twitter,
                              fieldsState: $tourist.isValidData)

                CustTextField(placeholder: "Дата рождения",
                              value: $tourist.birthDate,
                              keyboardType: .default,
                              fieldsState: $tourist.isValidData,
                              wihtDataPicker: true)

                CustTextField(placeholder: "Гражданство",
                              value: $tourist.nationality,
                              keyboardType: .twitter,
                              fieldsState: $tourist.isValidData)

                CustTextField(placeholder: "Номер загран паспорта",
                              value: $tourist.passportCode,
                              keyboardType: .decimalPad,
                              fieldsState: $tourist.isValidData)

                CustTextField(placeholder: "Срок действия загранпаспорта",
                              value: $tourist.passportValidityPeriod,
                              keyboardType: .default,
                              fieldsState: $tourist.isValidData)
            }
        }
    }
}
