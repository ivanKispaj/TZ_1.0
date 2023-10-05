//
//  DropDownView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI


struct DropDownView: View
{
    let touristStr: String
    @Binding var tourist: TouristModel
    
    @State var isDrop: Bool = false
    
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            HStack
            {
                Text("Турист \(touristStr)")
                    .font(Font(Constants.Fonts.sfpro22Regular))
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                Spacer()
                Button {
                    // drop menu
                    isDrop.toggle()
                    
                } label: {
                    Image(systemName: isDrop == true ? "chevron.down" : "chevron.up")
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                    
                }
                .frame(width: 32,height: 32)
                .background(Constants.Colors.buttonBackGRopac10)
                .cornerRadius(6)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
                
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            if (isDrop)
            {
                VStack
                {
                    CustTextField(placeholder: "Имя", isValidData: $tourist.isValidData, value: $tourist.name)
                    
                    CustTextField(placeholder: "Фамилия", isValidData: $tourist.isValidData, value: $tourist.lastName)
                    
                    CustTextField(placeholder: "Дата рождения", wihtDataPicker: true , isValidData: $tourist.isValidData, value: $tourist.birthDate)
                    
                    CustTextField(placeholder: "Гражданство", isValidData: $tourist.isValidData, value: $tourist.nationality)
                    
                    CustTextField(placeholder: "Номер загран паспорта", isValidData: $tourist.isValidData, value: $tourist.passportCode)
                    
                    CustTextField(placeholder: "Срок действия загранпаспорта", isValidData: $tourist.isValidData, value: $tourist.passportValidityPeriod)
                    
                }
            }
        }
    }
}
