//
//  PrimerTextField.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class PrimerTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: .mediumSpace, bottom: 0, right: .mediumSpace)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
}
