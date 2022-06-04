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
}

extension CardPaymentTextFieldViewModel {
    func shouldChangeCharacters(textField: UITextField, range: NSRange, replacementString: String) -> Bool {
        return true
    }
}
