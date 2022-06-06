//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol PaymentViewDelegate: AnyObject {
    func paymentView(_ paymentView: PaymentView, didAuthorizePaymentForToken token: String)
}

protocol PaymentViewProtocol: AnyObject {
    var delegate: PaymentViewDelegate? { get set }
}

typealias PaymentView = UIView & PaymentViewProtocol
