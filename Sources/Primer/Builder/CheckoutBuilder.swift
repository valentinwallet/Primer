//
//  PrimerCheckoutBuilder.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

public final class CheckoutBuilder {
    private var configuration: CheckoutBuilderConfiguration = CheckoutBuilderConfiguration()
    private var paymentMethods: [PaymentMethod] = [.card]
    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()) {
        self.viewControllerFactory = viewControllerFactory
    }

    public func build() -> CheckoutBaseViewController {
        return self.viewControllerFactory.createCheckoutViewController(configuration: self.configuration, paymentMethods: self.paymentMethods)
    }
}

// MARK: - Customization methods

extension CheckoutBuilder {
    public func payButtonCornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.configuration.payButtonCornerRadius = cornerRadius
        return self
    }

    public func payButtonColor(_ color: UIColor) -> Self {
        self.configuration.payButtonBackgroundColor = color
        return self
    }

    public func payButtonImage(_ image: UIImage?) -> Self {
        self.configuration.payButtonImage = image
        return self
    }

    public func payButtonTitle(_ title: String) -> Self {
        self.configuration.payButtonTitle = title
        return self
    }

    public func payButtonTitleColor(_ color: UIColor) -> Self {
        self.configuration.payButtonTitleColor = color
        return self
    }

    public func addPaymentMethod(_ paymentMethod: PaymentMethod) -> Self {
        if !self.paymentMethods.contains(paymentMethod) {
            self.paymentMethods.append(paymentMethod)
        }
        return self
    }
}


