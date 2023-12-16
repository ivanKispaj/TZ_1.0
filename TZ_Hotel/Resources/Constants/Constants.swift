//
//  Constants.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }
}

enum Constants {
    static var apiHost: String {
        return "run.mocky.io"
    }

    enum Colors {
        static var textFieldForeground: Color {
            return Color(hex: 0x14142B)
        }

        static var black: Color {
            return Color(hex: 0x000000)
        }

        static var white: Color {
            return Color(hex: 0xFFFFFF)
        }

        static var textFieldWarning: Color {
            return Color(hex: 0xEB5757, alpha: 0.15)
        }

        static var textFieldBackground: Color {
            return Color(hex: 0xF6F6F9)
        }

        static var textFieldPlace: Color {
            return Color(hex: 0xA9ABB7)
        }

        static var buttonBackGRopac10: Color {
            return Color(hex: 0x0D72FF, alpha: 0.1)
        }

        static var buttonBlueTint: Color {
            return Color(hex: 0x0D72FF)
        }

        static var basicBackground: Color {
            return Color(hex: 0xE8E9EC)
        }

        static var headline3: Color {
            return Color(hex: 0xFFFFFF)
        }

        static var ratingColor: Color {
            return Color(hex: 0xFFA800)
        }

        static var ratingBackground: Color {
            return Color(hex: 0xFFC700, alpha: 0.2)
        }

        static var dividerColor: Color {
            return Color(hex: 0x828796)
        }

        static var greyTintColor: Color {
            return dividerColor
        }

        static var backGroundPeculiarities: Color {
            return Color(hex: 0xFBFBFC)
        }

        static var colorDescription: Color {
            return Color(hex: 0x000000, alpha: 0.9)
        }

        static var buttonGrayBackground: Color {
            return backGroundPeculiarities
        }

        static var buttonTitleBlack: Color {
            return Color(hex: 0x2C3035)
        }
    }

    enum Fonts {
        private static var sfProDisplaySemiboldName: String {
                return "SFProDisplay-Semibold"
        }
        
        private static var sfProDisplayMediumName: String {
                return "SFProDisplay-Medium"
        }
        
        private static var sfProDisplayRegularName: String {
                return "SFProDisplay-Regular"
        }
        
        static var sfpro30Semibold: UIFont {
            return UIFont(name: sfProDisplaySemiboldName, size: 30) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var sfpro22Medium: UIFont {
            return UIFont(name: sfProDisplayMediumName, size: 22) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var headline1: UIFont {
            return UIFont(name: sfProDisplayMediumName, size: 18) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var playsholder17: UIFont {
            return UIFont(name: sfProDisplayRegularName, size: 17) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var headline3: UIFont {
            return UIFont(name: sfProDisplayMediumName, size: 16) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }
        
        static var sfpro16Medium: UIFont {
            return  headline3
        }
        
        static var sfpro16Semibold: UIFont {
            return UIFont(name: sfProDisplaySemiboldName, size: 16) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var sfpro16Regular: UIFont {
            return UIFont(name: sfProDisplayRegularName, size: 16) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var sfpro14Medium: UIFont {
            return UIFont(name: sfProDisplayMediumName, size: 14) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var sfpro14Regular: UIFont {
            return UIFont(name: sfProDisplayRegularName, size: 14) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }

        static var callout2: UIFont {
            return UIFont(name: sfProDisplayRegularName, size: 12) ?? UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        }
    }

    enum ImagesName {
        static var emojiHappy: String {
            return "emojiHappy"
        }

        static var vector: String {
            return "vector"
        }
    }
}
