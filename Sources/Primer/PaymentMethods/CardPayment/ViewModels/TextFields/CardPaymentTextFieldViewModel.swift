//
//  CardPaymentTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

protocol CardPaymentTextFieldViewModel: AnyObject {
    var title: String { get }
    var keyboardType: UIKeyboardType { get }

    func shouldChangeCharacters(textField: UITextField, range: NSRange, replacementString: String) -> Bool
    func validate(for text: String) -> Bool
    func format(textFieldText text: String) -> String
    func expiryMonth(textFieldText text: String) -> String
    func expiryYear(textFieldText text: String) -> String
}

extension CardPaymentTextFieldViewModel {
    func shouldChangeCharacters(textField: UITextField, range: NSRange, replacementString: String) -> Bool {
        return true
    }

    func format(textFieldText text: String) -> String {
        return text
    }

    func expiryMonth(textFieldText text: String) -> String { return "" }
    func expiryYear(textFieldText text: String) -> String { return "" }
}
