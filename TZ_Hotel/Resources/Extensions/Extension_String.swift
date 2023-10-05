//
//  Extension_String.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 04.10.2023.
//

import UIKit
import SwiftUI

extension String
{
    func wordWidth(_ font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return ceil(size.width)
    }
}
