//
//  CheckoutViewControllerFactory.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol CheckoutViewControllerFactoryProtocol {
    func createCheckoutViewController(paymentMethodSectionViews: [UIView]) -> CheckoutViewController
}

final class CheckoutViewControllerFactory: CheckoutViewControllerFactoryProtocol {
    func createCheckoutViewController(paymentMethodSectionViews: [UIView]) -> CheckoutViewController {
        let viewModel = CheckoutViewModel(paymentMethodSectionViews: paymentMethodSectionViews)
        return CheckoutViewController(viewModel: viewModel)
    }
}
