//
//  Extension_Font.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 04.10.2023.
//

import UIKit
import SwiftUI

extension Font
{
    init(_ uiFont: UIFont)
    {
        self = Font(uiFont as CTFont)
    }
}
