//
//  CarouselImage.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct CarouselImage: View {
    var item: [UIImage]
    @State var selected = 0

    var body: some View {
        TabView(selection: $selected) {
            ForEach(0 ..< item.count, id: \.self) { imgIndex in
                Image(uiImage: item[imgIndex])
                    .resizable()
                    .frame(height: 257)
                    .ignoresSafeArea()
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            customTabView()
        }
        .frame(height: 257)
    }

    @ViewBuilder private func customTabView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(0 ..< item.count, id: \.self) { index in

                    Circle()
                        .fill(Color.black.opacity(getCircleOpacityFromIndex(selected, index)))
                        .frame(width: 7, height: 7)
                        .padding(EdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5))
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color(.white))
        .frame(height: 17)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
    }

    private func getCircleOpacityFromIndex(_ selectedIndex: Int, _ curentIndex: Int) -> Double {
        if curentIndex == selectedIndex {
            return 1
        }

        let startOpacity = 0.22

        if curentIndex < selectedIndex {
            return startOpacity / Double(selectedIndex - curentIndex)
        }

        return startOpacity / Double(curentIndex - selectedIndex)
    }
}
