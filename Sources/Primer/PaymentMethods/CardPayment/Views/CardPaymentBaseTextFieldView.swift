//
//  CardPaymentBaseTextFieldView.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

protocol CardPaymentTextFieldViewProtocol {
    var viewModel: CardPaymentTextFieldViewModel { get }
    var textField: UITextField { get }
    var delegate: CardPaymentTextFieldViewDelegate? { get set }

    func validate() -> Bool
    func textFieldText() -> String
    func expirationMonth() -> String
    func expirationYear() -> String
}

extension CardPaymentTextFieldViewProtocol {
    func validate() -> Bool {
        return self.viewModel.validate(for: self.textField.text ?? "")
    }

    func textFieldText() -> String {
        let textFieldText = self.textField.text ?? ""
        return self.viewModel.format(textFieldText: textFieldText)
    }

    func expirationMonth() -> String {
        let textFieldText = self.textField.text ?? ""
        return self.viewModel.expiryMonth(textFieldText: textFieldText)
    }

    func expirationYear() -> String {
        let textFieldText = self.textField.text ?? ""
        return self.viewModel.expiryYear(textFieldText: textFieldText)
    }
}

typealias CardPaymentBaseTextFieldView = UIView & CardPaymentTextFieldViewProtocol
