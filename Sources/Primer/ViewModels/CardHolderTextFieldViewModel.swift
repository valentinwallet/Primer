//
//  CardHolderTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CardHolderTextFieldViewModel: CardPaymentTextFieldViewModel {
    let title: String = "Cardholder Name"
    let keyboardType: UIKeyboardType = .numberPad

    func validate(for text: String) -> Bool {
        return true
    }
}
