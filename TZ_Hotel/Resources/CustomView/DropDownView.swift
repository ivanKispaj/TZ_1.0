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
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.name.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                CustTextField(placeholder: "Фамилия", value: $tourist.lastName,
                              keyboardType: .alphabet)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.lastName.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                CustTextField(placeholder: "Дата рождения", value: $tourist.birthDate,
                              keyboardType: .alphabet, wihtDataPicker: true)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.birthDate.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
                CustTextField(placeholder: "Гражданство", value: $tourist.nationality,
                              keyboardType: .alphabet)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.nationality.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)

                CustTextField(placeholder: "Номер загран паспорта", value: $tourist.passportCode,
                              keyboardType: .decimalPad)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData && tourist.passportCode.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)

                CustTextField(placeholder: "Срок действия загранпаспорта", value: $tourist.passportValidityPeriod,
                              keyboardType: .default)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(tourist.isValidData || (!tourist.isValidData &&
                            tourist.passportValidityPeriod.count > 0)
                        ? Constants.Colors.textFieldBackground :
                        Constants.Colors.textFieldWarning)
            }
        }
    }
}
