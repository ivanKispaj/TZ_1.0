//
//  GroupedText.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI

struct GroupedText: View {
    var data: [[String]]
    var body: some View {
        ForEach(data, id: \.self) { words in
            HStack(spacing: 0) {
                ForEach(words, id: \.self) { word in
                    Text(word)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .font(Font(Constants.Fonts.sfpro16Medium))
                        .background(Constants.Colors.backGroundPeculiarities)
                        .foregroundColor(Constants.Colors.dividerColor)
                        .cornerRadius(5)
                    Spacer()
                        .frame(width: 5, alignment: .leading)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        }
    }
}
