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

    func textFieldDidChange(textField: UITextField) {
        guard let textFieldText = textField.text else { return }
        textField.text = self.modifyCreditCardString(creditCardString: textFieldText)
    }

    private func modifyCreditCardString(creditCardString : String) -> String {
         let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

         let characterArray = Array(trimmedString)
         var finalCardString = ""

         if characterArray.count > 0 {
             for i in 0...characterArray.count - 1 {
                 finalCardString.append(characterArray[i])
                 if ((i + 1) % 4 == 0 && i + 1 != characterArray.count) {
                     finalCardString.append(" ")
                 }
             }
         }

         return finalCardString
     }
}
