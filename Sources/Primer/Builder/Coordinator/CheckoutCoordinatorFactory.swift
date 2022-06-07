//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

protocol CheckoutCoordinatorFactoryProtocol {
    func createCheckoutBuilderCoordinator(paymentMethods: [PaymentMethod],
                                          configuration: CheckoutBuilderConfiguration) -> CheckoutCoordinatorProtocol
}

final class CheckoutCoordinatorFactory: CheckoutCoordinatorFactoryProtocol {
    private let checkoutViewControllerFactory: CheckoutViewControllerFactoryProtocol

    init(checkoutViewControllerFactory: CheckoutViewControllerFactoryProtocol = CheckoutViewControllerFactory()) {
        self.checkoutViewControllerFactory = checkoutViewControllerFactory
    }

    func createCheckoutBuilderCoordinator(paymentMethods: [PaymentMethod],
                                          configuration: CheckoutBuilderConfiguration) -> CheckoutCoordinatorProtocol {
        return CheckoutCoordinator(paymentMethods: paymentMethods, configuration: configuration, checkoutViewControllerFactory: self.checkoutViewControllerFactory)
    }
}
