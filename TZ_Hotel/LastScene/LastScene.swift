//
//  LastScene.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 01.10.2023.
//

import SwiftUI

struct LastScene: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Circle()
                    .frame(width: 94)
                    .foregroundColor(Constants.Colors.textFieldBackground)
                    .overlay {
                        Image("partyPopper")
                            .frame(width: 44, height: 44)
                    }
                VStack(alignment: .center) {
                    Text("Ваш заказ принят в работу")
                        .font(Font(Constants.Fonts.sfpro22Medium))
                        .foregroundStyle(Constants.Colors.black)
                }
                .padding(EdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10))

                VStack(alignment: .center, spacing: 0) {
                    Text(
                        """
                        Подтверждение заказа №\(String(Int.random(in: 1000 ... 60000)))
                         может занять некоторое время (от 1 часа до суток).
                         Как только мы получим ответ от туроператора,
                         вам на почту придет уведомление.
                        """
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.greyTintColor)
                    .font(Font(Constants.Fonts.sfpro16Regular))
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

                Spacer()
                SelectedButton(buttonText: "Супер!") {
                    coordinator.poptoRoot()
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
        }
        .background(Constants.Colors.white)
    }
}

//
// struct LastScene_Previews: PreviewProvider {
//    static var previews: some View {
//        LastScene(title: "Заказ оплачен")
//    }
// }
