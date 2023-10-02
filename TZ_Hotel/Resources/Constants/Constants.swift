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
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

enum Constants
{
    enum Colors
    {
        
        
        static var textFieldWarning: Color
        {
            return Color(hex: 0xEB5757,alpha: 0.15)
        }
        
        static var textFieldBackground: Color
        {
            return Color(hex: 0xF6F6F9)
        }
        
        static var textFieldPlace: Color
        {
            return Color(hex: 0xA9ABB7)
        }
        
        static var buttonBackGRopac10: Color
        {
            return Color(hex: 0x0D72FF,alpha: 0.1)
        }
        
        static var buttonBlueTint: Color
        {
            return Color(hex: 0x0D72FF)
        }
        
        
        static var basicBackground: Color
        {
            return Color(hex: 0xE8E9EC)
        }
        
        static var headline3: Color
        {
            return Color(hex: 0xFFFFFF)
        }
        
        static var ratingColor: Color
        {
            return Color(hex: 0xFFA800)
        }
        
        static var ratingBackground: Color
        {
            return Color(hex: 0xFFC700,alpha: 0.2)
        }
        
        static var derivrdColor: Color
        {
            return Color(hex: 0x828796,alpha: 0.15)
        }
        
        static var greyTintColor: Color
        {
            return Color(hex: 0x828796)
        }
        
        static var backGroundPeculiarities: Color
        {
            return Color(hex: 0xFBFBFC)
        }
        
        static var colorDescription: Color
        {
            return Color(hex: 0x000000, alpha: 0.9)
        }
        
        static var buttonGrayBackground: Color
        {
            return Color(hex: 0xFBFBFC)
        }
        
        static var buttonTitleBlack: Color
        {
            return Color(hex: 0x2C3035)
        }
        
        
        
    }
    
    enum ApiURL
    {
        static var hotelSceneUrl: URL?
        {
            return URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3")
        }
        
        static var roomsSceneUrl: URL?
        {
            return URL(string: "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd")
        }
        
        static var bookingSceneUrl: URL?
        {
            return URL(string: "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8")
        }
    }
    
    
    enum Fonts
    {
        static var headline1: Font
        {
            return Font.system(size: 18,weight: .regular, design: .default)
        }
        
        static var playsholder17: Font
        {
            return Font.system(size: 17,weight: .light, design: .default)
        }
        
        static var sfpro16Regular: Font
        {
            return Font.system(size: 16,weight: .regular, design: .default)
        }
        
        static var sfpro22Regular: Font
        {
            return Font.system(size: 22,weight: .regular, design: .default)
        }
        
        static var sfpro14Regular: Font
        {
            return Font.system(size: 14,weight: .regular, design: .default)
        }
        
        static var sfpro30Medium: Font
        {
            return Font.system(size: 30,weight: .medium, design: .default)
        }
        
        static var sfpro14Light: Font
        {
            return Font.system(size: 14,weight: .light, design: .default)
        }
        
        static var sfpro16Light: Font
        {
            return Font.system(size: 16,weight: .light, design: .default)
        }
        
        static var sfpro16Bold: Font
        {
            return Font.system(size: 16,weight: .bold, design: .default)
        }
        
        static var callout2: Font
        {
            return Font.system(size: 12,weight: .light, design: .default)
        }
        
        
    }
    
    enum imagesName
    {
        static var emojiHappy: String
        {
            return "emojiHappy"
        }
        
        static var vector: String
        {
            return "vector"
        }
        
    }
}
