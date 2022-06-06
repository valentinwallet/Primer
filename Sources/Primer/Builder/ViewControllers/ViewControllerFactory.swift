//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

protocol ViewControllerFactoryProtocol {
    func createCheckoutViewController(configuration: CheckoutBuilderConfiguration, paymentMethods: [PaymentMethod]) -> UIViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    func createCheckoutViewController(configuration: CheckoutBuilderConfiguration, paymentMethods: [PaymentMethod]) -> UIViewController {
        let viewModel = CheckoutViewModel(configuration: configuration, paymentMethods: paymentMethods)
        return CheckoutViewController(viewModel: viewModel)
    }
}
