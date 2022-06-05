//
//  PrimerCheckoutBuilder.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

struct PrimerCheckoutBuilderConfiguration {
    var payButtonCornerRadius: CGFloat = .smallCornerRadius
    var payButtonBackgroundColor: UIColor = .systemBackgroundInverted
    var payButtonImage: UIImage?
    var payButtonTitle: String = "Pay"
    var payButtonTitleColor: UIColor = .systemBackground
}

public enum PrimerPaymentMethod {
    case card
}

public enum Primer {
    public static func checkoutBuilder() -> Primer.CheckoutBuilder {
        return CheckoutBuilder()
    }
}

extension Primer {
    public final class CheckoutBuilder {
        private var configuration: PrimerCheckoutBuilderConfiguration = PrimerCheckoutBuilderConfiguration()
        private var paymentMethods: [PrimerPaymentMethod] = [.card]

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

        public func addPaymentMethod(_ paymentMethod: PrimerPaymentMethod) -> Self {
            if !self.paymentMethods.contains(paymentMethod) {
                self.paymentMethods.append(paymentMethod)
            }
            return self
        }

        public func build() -> UIViewController {
            let viewModel = PrimerCheckoutViewModel(configuration: self.configuration, paymentMethods: self.paymentMethods)
            return PrimerCheckoutViewController(viewModel: viewModel)
        }
    }
}

