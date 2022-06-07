//
//  CardPaymentCoordinator.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit

final class CardPaymentCoordinator {
    private let configuration: CheckoutBuilderConfiguration

    weak var delegate: PaymentMethodCoordinatorDelegate?

    init(configuration: CheckoutBuilderConfiguration) {
        self.configuration = configuration
    }

    private func createCardPaymentView() -> UIView {
        let viewModel = CardPaymentViewModel(configuration: self.configuration)
        let view = CardPaymentView(viewModel: viewModel)

        view.delegate = self

        return view
    }
}

// MARK: - PaymentMethodCoordinator
extension CardPaymentCoordinator: PaymentMethodCoordinator {
    func start() -> UIView {
        return self.createCardPaymentView()
    }
}

// MARK: - CardPaymentViewDelegate
extension CardPaymentCoordinator: CardPaymentViewDelegate {
    func cardPaymentView(_ cardPaymentView: CardPaymentView, didAuthorizePaymentMethodForToken token: String) {
        self.delegate?.paymentMethodCoordinator(self, didAuthorizePaymentMethodForToken: token)
    }

    func cardPaymentView(_ cardPaymentView: CardPaymentView, didFailAuthorizePaymentMethodWithError error: PrimerAPIError) {
        self.delegate?.paymentMethodCoordinator(self, didFailAuthorizePaymentMethodWithError: error)
    }
}
