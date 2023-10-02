//
//  ConnectError.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import Foundation


enum ConnectError: String, Error{
    case noConnect = "Error conn erction to server"
    case parseError = "Error parse data"
}
extension ConnectError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnect:
            return NSLocalizedString("Failure connection to internet or bad server response", comment: "Inet connection failed")
        case .parseError:
            return NSLocalizedString("Parse data response error, maybe bad server response", comment: "Parse error")
        }
    }
}
