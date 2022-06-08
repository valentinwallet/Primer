//
//  CheckoutCoordinator.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit
import Combine
import PassKit

/// Will coordinate everything in order to create a `CheckoutViewController` and send back authorization token
public final class CheckoutCoordinator: CheckoutCoordinatorProtocol {
    public var tokenPublisher: AnyPublisher<TokenValue, Never> { self.subject.eraseToAnyPublisher() }
    private let subject = PassthroughSubject<TokenValue, Never>()
    public var delegate: CheckoutCoordinatorDelegate?
    public var onTokenSuccess: ((String) -> Void)?
    public var onTokenFailure: ((PrimerAPIError) -> Void)?

    private(set) var navigationController: UINavigationController?

    private let paymentMethods: [PaymentMethod]
    private let configuration: CheckoutBuilderConfiguration
    private var paymentMethodSections: [PaymentMethodCoordinator] = []
    private let checkoutViewControllerFactory: CheckoutViewControllerFactoryProtocol

    init(paymentMethods: [PaymentMethod],
         configuration: CheckoutBuilderConfiguration,
         checkoutViewControllerFactory: CheckoutViewControllerFactoryProtocol) {
        self.paymentMethods = paymentMethods
        self.configuration = configuration
        self.checkoutViewControllerFactory = checkoutViewControllerFactory
    }

    public func start(from presentingViewController: UIViewController) -> Self {
        self.buildPaymentMethodSections()

        let paymentMethodSectionViews = self.getPaymentMethodSectionViews()
        let checkoutViewController = self.checkoutViewControllerFactory
            .createCheckoutViewController(paymentMethodSectionViews: paymentMethodSectionViews)
        let navigationController = UINavigationController(rootViewController: checkoutViewController)
        self.navigationController = navigationController

        presentingViewController.present(navigationController, animated: true, completion: nil)

        return self
    }

    private func buildPaymentMethodSections() {
        for paymentMethod in self.paymentMethods {
            switch paymentMethod {
            case .card:
                let paymentMethodSection = CardPaymentCoordinator(configuration: self.configuration)
                paymentMethodSection.delegate = self
                self.paymentMethodSections.append(paymentMethodSection)
            case .applePay(let merchantId):
                let paymentMethodSection = ApplePayCoordinator(merchantId: merchantId)
                paymentMethodSection.delegate = self
                self.paymentMethodSections.append(paymentMethodSection)
            }
        }
    }

    private func getPaymentMethodSectionViews() -> [UIView] {
        return self.paymentMethodSections.map { return $0.start() }
    }
}

extension CheckoutCoordinator: PaymentMethodCoordinatorDelegate {
    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didAuthorizePaymentMethodForToken token: String) {
        self.delegate?.checkoutBuilderCoordinator(self, didAuthorizeMethodPaymentForToken: token)
        self.subject.send(.success(token: token))
        self.onTokenSuccess?(token)
    }

    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didFailAuthorizePaymentMethodWithError error: PrimerAPIError) {
        self.delegate?.checkoutBuilderCoordinator(self, didFailAuthorizePaymentMethodWithError: error)
        self.subject.send(.failure(error: error))
        self.onTokenFailure?(error)
    }
}
