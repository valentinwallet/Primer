//
//  PrimerCheckoutViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

final class PrimerCheckoutViewModel {
    let configuration: PrimerCheckoutBuilderConfiguration
    let paymentMethods: [PrimerPaymentMethod]

    init(configuration: PrimerCheckoutBuilderConfiguration, paymentMethods: [PrimerPaymentMethod]) {
        self.configuration = configuration
        self.paymentMethods = paymentMethods
    }

    func getPaymentMethodViews() -> [UIView] {
        var views: [UIView] = []

        for paymentMethod in paymentMethods {
            views.append(self.getPaymentMethodView(for: paymentMethod))
        }

        return views
    }

    private func getPaymentMethodView(for paymentMethod: PrimerPaymentMethod) -> UIView {
        switch paymentMethod {
        case .card:
            let viewModel = CardPaymentViewModel(configuration: self.configuration)
            let cardPaymentView = CardPaymentView(viewModel: viewModel)
            return cardPaymentView
        }
    }
}
