//
//  Formatter.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 06.10.2023.
//

import Foundation

class Formatter {
    private lazy var wordInteger: [String] = ["Первый", "Второй", "Третий", "Четвертый", "Пятый",
                                              "Шестой", "Седьиой", "Восьмой", "Девятый",
                                              "Десятый", "Одинадцатый", "Двенадцатый",
                                              "Тринадцатый", "Четырнадцатый", "Пятнадцатый",
                                              "Шестнадцатый", "Семнадцатый", "Восемнадцатый",
                                              "Девятнадцатый", "Двадцатый"]
    private lazy var formater: NumberFormatter = {
        let formater = NumberFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.groupingSeparator = " "
        return formater
    }()

    private lazy var phoneMask: String = "+7(***)***-**-**"

    private var inputNumber: String = ""

    func integerToWord(_ integer: Int) -> String {
        if integer < wordInteger.count {
            return wordInteger[integer]
        }
        return "..."
    }

    func iтtegerToMoneyString(_ num: Int, with sign: String) -> String {
        formater.numberStyle = .decimal

        if var money = formater.string(from: NSNumber(value: num)) {
            money += " " + sign
            return money
        }
        return ""
    }

    func formattesPhone(value: String?) -> String? {
        guard var number = value else { return phoneMask }

        if number.count > phoneMask.count {
            if inputNumber.count < 10 {
                let val = number.removeLast()
                if val.isNumber {
                    inputNumber.append(val)
                }
            }

        } else if number.count < phoneMask.count {
            if inputNumber.count > 0 {
                inputNumber.removeLast()
            }
        }

        let mask = phoneMask
        var result = ""
        var index = inputNumber.startIndex
        for char in mask where index < mask.endIndex {
            if char == "*" {
                if inputNumber.indices.contains(index) {
                    result.append(inputNumber[index])
                    index = number.index(after: index)
                } else {
                    result.append(char)
                }
            } else {
                result.append(char)
            }
        }
        return result
    }
}
