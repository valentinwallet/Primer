//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol PaymentViewDelegate: AnyObject {
    func paymentView(_ paymentView: PaymentView, didAuthorizePaymentForToken token: String)
    func paymentView(_ paymentView: PaymentView, didFailPaymentWithError error: PrimerAPIError)
}

protocol PaymentViewProtocol: AnyObject {
    var delegate: PaymentViewDelegate? { get set }
}

typealias PaymentView = UIView & PaymentViewProtocol
