//
//  String+Extension.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import Foundation

extension String {
    var onlyContainsLetters: Bool {
        guard self.count > 0 else { return false }
        return CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: self))
    }

    var onlyContainsNumbers: Bool {
        guard self.count > 0 else { return false }
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    var removeWhitespaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
