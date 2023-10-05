//
//  Extension_Array.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 04.10.2023.
//

import SwiftUI

extension Array<String>
{
    
    func createLineArrsString(_ font: UIFont, _ paddingsSize: CGFloat) -> [[String]] {
        var arr: [[String]] = []
        var currentRow: [String] = []
        
        for (index, value) in self.enumerated()
        {
            let rowWidth = currentRow.reduce(0) { $0 + $1.wordWidth(font) + paddingsSize }
            let availableWidth = UIScreen.main.bounds.width // Adjust the padding as needed
            if rowWidth + value.wordWidth(font) > availableWidth
            {
                arr.append(currentRow)
                currentRow = []
                currentRow.append(value)
                
            } else
            {
                currentRow.append(self[index])
            }
        }
        if !currentRow.isEmpty
        {
            arr.append(currentRow)
            
        }
        return arr
    }
}
