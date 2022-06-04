//
//  CardHolderNameTextFieldViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CardHolderNameTextFieldViewModel: CardPaymentTextFieldViewModel {
    let title: String = "Cardholder Name"
    let keyboardType: UIKeyboardType = .default

    func validate(for text: String) -> Bool {
        return true
    }
}
