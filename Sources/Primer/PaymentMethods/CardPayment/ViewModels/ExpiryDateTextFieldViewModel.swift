//
//  ExpiryDateTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class ExpiryDateTextFieldViewModel: CardPaymentTextFieldViewModel {
    let title: String = "Expiry Date"
    let keyboardType: UIKeyboardType = .numberPad

    func shouldChangeCharacters(textField: UITextField, range: NSRange, replacementString: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let updatedText = oldText.replacingCharacters(in: r, with: replacementString)

        if replacementString == "" {
            if updatedText.count == 2 {
                textField.text = "\(updatedText.prefix(1))"
                return false
            }
        } else if updatedText.count == 1 {
            if updatedText > "1" {
                return false
            }
        } else if updatedText.count == 2 {
            if updatedText >= "01" && updatedText <= "12" {
                textField.text = "\(updatedText)/"
            }
            return false
        } else if updatedText.count > 5 {
            return false
        }

        return true
    }

    func validate(for text: String) -> Bool {
        guard let expiryDate = DateFormatter.cardExpiryDateFormatter.date(from: text) else { return false }
        return expiryDate > Date()
    }

    func expiryYear(textFieldText text: String) -> String {
        guard let expiryDate = DateFormatter.cardExpiryDateFormatter.date(from: text) else { return "" }

        return DateFormatter.yearFormatter.string(from: expiryDate)
    }

    func expiryMonth(textFieldText text: String) -> String {
        guard let expiryDate = DateFormatter.cardExpiryDateFormatter.date(from: text) else { return "" }

        return DateFormatter.monthFormatter.string(from: expiryDate)
    }
}
