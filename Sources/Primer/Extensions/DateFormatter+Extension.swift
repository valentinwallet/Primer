//
//  DateFormatter+Extension.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import Foundation

extension DateFormatter {
    static let cardExpiryDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter
    }()

    static let milliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return formatter
    }()
}
