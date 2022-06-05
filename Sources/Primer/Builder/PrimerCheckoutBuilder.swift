//
//  PrimerCheckoutBuilder.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

struct PrimerCheckoutBuilderConfiguration {
    var payButtonCornerRadius: CGFloat = .smallCornerRadius
    var payButtonColor: UIColor = .systemBackgroundInverted
    var payButtonImage: UIImage?
}

public final class PrimerCheckoutBuilder {
    private var configuration: PrimerCheckoutBuilderConfiguration = PrimerCheckoutBuilderConfiguration()

    func payButtonCornerRadius(cornerRadius: CGFloat) -> Self {
        self.configuration.payButtonCornerRadius = cornerRadius
        return self
    }

    func payButtonColor(color: UIColor) -> Self {
        self.configuration.payButtonColor = color
        return self
    }

    func payButtonImage(image: UIImage) -> Self {
        self.configuration.payButtonImage = image
        return self
    }

    func build() -> UIViewController {
        return UIViewController()
    }
}
