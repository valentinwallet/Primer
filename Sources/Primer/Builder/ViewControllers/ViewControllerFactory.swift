//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol ViewControllerFactoryProtocol {
    func createCheckoutViewController(configuration: CheckoutBuilderConfiguration, paymentMethods: [PaymentMethod]) -> CheckoutBaseViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    func createCheckoutViewController(configuration: CheckoutBuilderConfiguration, paymentMethods: [PaymentMethod]) -> CheckoutBaseViewController {
        let viewModel = CheckoutViewModel(configuration: configuration, paymentMethods: paymentMethods)
        return CheckoutViewController(viewModel: viewModel)
    }
}
