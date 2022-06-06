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
}

extension CardPaymentTextFieldViewProtocol {
    func validate() -> Bool {
        return self.viewModel.validate(for: self.textField.text ?? "")
    }

    func textFieldText() -> String {
        return self.textField.text ?? ""
    }
}

typealias CardPaymentBaseTextFieldView = UIView & CardPaymentTextFieldViewProtocol
