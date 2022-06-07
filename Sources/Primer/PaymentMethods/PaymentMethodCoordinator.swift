//
//  PaymentMethodCoordinator.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit

protocol PaymentMethodCoordinatorDelegate: AnyObject {
    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didAuthorizePaymentMethodForToken token: String)
    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didFailAuthorizePaymentMethodWithError error: PrimerAPIError)
}

protocol PaymentMethodCoordinator {
    func start() -> UIView

    var delegate: PaymentMethodCoordinatorDelegate? { get set }
}
