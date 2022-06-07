//
//  CardNumberTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CardNumberTextFieldViewModel: CardPaymentTextFieldViewModel {
    let title: String = "Card Number"
    let keyboardType: UIKeyboardType = .numberPad

    func validate(for text: String) -> Bool {
        return text
            .removeWhitespaces
            .onlyContainsNumbers
    }

    func format(textFieldText text: String) -> String {
        return text.removeWhitespaces
    }
}
