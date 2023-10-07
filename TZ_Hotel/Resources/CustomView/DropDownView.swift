//
//  DropDownView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct DropDownView: View {
    let touristStr: String
    @Binding var tourist: TouristModel
    @State var isDrop: Bool = false

    var body: some View {
        HStack {
            Text("\(touristStr) турист")
                .font(Font(Constants.Fonts.sfpro22Regular))
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
                CustTextField(placeholder: "Имя", value: $tourist.name,
                              keyboardType: .alphabet)
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.name.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)
                CustTextField(placeholder: "Фамилия", value: $tourist.lastName,
                              keyboardType: .alphabet)
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.lastName.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)

                CustTextField(placeholder: "Дата рождения", value: $tourist.birthDate,
                              keyboardType: .alphabet, wihtDataPicker: true)
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.birthDate.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)

                CustTextField(placeholder: "Гражданство", value: $tourist.nationality,
                              keyboardType: .alphabet)
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.nationality.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)
                CustTextField(placeholder: "Номер загран паспорта", value: $tourist.passportCode,
                              keyboardType: .decimalPad)
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.passportCode.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)
                CustTextField(placeholder: "Срок действия загранпаспорта", value: $tourist.passportValidityPeriod,
                              keyboardType: .default)
                    .background(tourist.isValidData || (!tourist.isValidData &&
                            tourist.passportValidityPeriod.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                    .cornerRadius(10)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}
