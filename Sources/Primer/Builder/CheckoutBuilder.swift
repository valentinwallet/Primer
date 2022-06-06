//
//  PrimerCheckoutBuilder.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

/// Builder used to create a `CheckoutBaseViewController`.
/// - Important: Remember to call the `build()` method after the customization of the `CheckoutBaseViewController` view.
public final class CheckoutBuilder {
    private var configuration: CheckoutBuilderConfiguration = CheckoutBuilderConfiguration()
    private var paymentMethods: [PaymentMethod] = [.card]
    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()) {
        self.viewControllerFactory = viewControllerFactory
    }

    /// Call this method to create a `CheckoutBaseViewController`.
    /// - Returns: CheckoutBaseViewController
    public func build() -> CheckoutBaseViewController {
        return self.viewControllerFactory.createCheckoutViewController(configuration: self.configuration, paymentMethods: self.paymentMethods)
    }
}

// MARK: - Customization methods

extension CheckoutBuilder {
    /// Method used to custom the corner radius of the pay button.
    /// - Parameter cornerRadius: Change the `cornerRadius` of the pay button.
    /// - Note: The default value of the pay button `cornerRadius` is 8.
    /// - Returns: CheckoutBuilder
    public func payButtonCornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.configuration.payButtonCornerRadius = cornerRadius
        return self
    }

    /// Method used to custom the `backgroundColor` of the pay button.
    /// - Parameter color: Change the `backgroundColor` of the pay button.
    /// - Note: The default value of the pay button `backgroundColor` is `.black` for light mode and `.white` for dark mode.
    /// - Returns: CheckoutBuilder
    public func payButtonColor(_ color: UIColor) -> Self {
        self.configuration.payButtonBackgroundColor = color
        return self
    }

    /// Method used to custom the `imageView` of the pay button.
    /// - Parameter image: Change the `imageView` of the pay button.
    /// - Note: The default value of the pay button `imageView` is nil.
    /// - Returns: CheckoutBuilder
    public func payButtonImage(_ image: UIImage?) -> Self {
        self.configuration.payButtonImage = image
        return self
    }

    /// Method used to custom the `title` of the pay button.
    /// - Parameter title: Change the `title` of the pay button.
    /// - Note: The default value of the pay button `title` is "Pay".
    /// - Returns: CheckoutBuilder
    public func payButtonTitle(_ title: String) -> Self {
        self.configuration.payButtonTitle = title
        return self
    }

    /// Method used to custom the `titleColor` of the pay button.
    /// - Parameter color: Change the `titleColor` of the pay button.
    /// - Note: The default value of the pay button `titleColor` is `.white` for light mode and `.dark` for dark mode.
    /// - Returns: CheckoutBuilder
    public func payButtonTitleColor(_ color: UIColor) -> Self {
        self.configuration.payButtonTitleColor = color
        return self
    }

    /// Method used to add an other payment method if needed.
    /// - Parameter paymentMethod: The new payment method to add.
    /// - Note: There is one payment method by default : `.card`.
    /// - Returns: CheckoutBuilder
    public func addPaymentMethod(_ paymentMethod: PaymentMethod) -> Self {
        if !self.paymentMethods.contains(paymentMethod) {
            self.paymentMethods.append(paymentMethod)
        }
        return self
    }
}


