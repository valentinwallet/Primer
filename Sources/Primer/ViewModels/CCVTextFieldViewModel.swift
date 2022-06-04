//
//  CCVTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CCVTextFieldViewModel: CardPaymentTextFieldViewModel {
    let title: String = "CCV Code"
    let keyboardType: UIKeyboardType = .numberPad

    func shouldChangeCharacters(textField: UITextField, range: NSRange, replacementString: String) -> Bool {
        guard let currentText = textField.text, let range = Range(range, in: currentText) else {
            return false
        }
        let updatedTextFieldText = currentText.replacingCharacters(in: range, with: replacementString)

        return updatedTextFieldText.count < 5
    }

    func validate(for text: String) -> Bool {
        return true
    }
}
