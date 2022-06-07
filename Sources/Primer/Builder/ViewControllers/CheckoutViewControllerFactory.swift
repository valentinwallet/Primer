//
//  CheckoutViewControllerFactory.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol CheckoutViewControllerFactoryProtocol {
    func createCheckoutViewController(paymentMethodSectionViews: [UIView]) -> UIViewController
}

final class CheckoutViewControllerFactory: CheckoutViewControllerFactoryProtocol {
    func createCheckoutViewController(paymentMethodSectionViews: [UIView]) -> UIViewController {
        let viewModel = CheckoutViewModel(paymentMethodSectionViews: paymentMethodSectionViews)
        return CheckoutViewController(viewModel: viewModel)
    }
}
