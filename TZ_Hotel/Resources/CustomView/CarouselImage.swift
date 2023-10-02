//
//  Carousel.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 30.09.2023.
//

import SwiftUI

struct CarouselImage: View
{
    var item: [UIImage]
    @State var selected = 0
    
    var body: some View
    {
        ZStack {
            Color.white.ignoresSafeArea()
            TabView (selection: $selected){
                ForEach(0..<item.count, id: \.self) { imgIndex in
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
    }
    
    @ViewBuilder private func customTabView() -> some View
    {
        ZStack{
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 7,height: 7)
                ForEach(0..<item.count, id: \.self) { index in
                    
                    Circle()
                        .fill(selected == index ? Color.black : Color.black.opacity(0.22))
                        .frame(width: 7,height: 7)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                    
                }
                Spacer()
                    .frame(width: 7,height: 7)
            }
            .background(Color(.white))
            .frame(height: 17)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }
}
