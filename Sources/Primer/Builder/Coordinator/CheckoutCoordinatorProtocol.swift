//
//  CheckoutCoordinatorProtocol.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import Combine
import UIKit

/// Delegate for `CheckoutBuilderCoordinator`
public protocol CheckoutCoordinatorDelegate: AnyObject {
    /// Will be called if we manage to get an authorization token from a `PaymentView`
    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didAuthorizeMethodPaymentForToken token: String)
    /// Will be called if we failed to get an authorization token from a `PaymentView`
    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didFailAuthorizePaymentMethodWithError error: PrimerAPIError)
}

/// Protocol with the different methods in order to get a valid token from a payment.
/// Three choices are available: delegate, publisher or a completion.
public protocol CheckoutCoordinatorProtocol: AnyObject {
    /// Delegation method to get back an authorization token from a payment view
    var delegate: CheckoutCoordinatorDelegate? { get set }
    /// Combine method to get back an authorization token from a payment view
    var tokenPublisher: AnyPublisher<TokenValue, Never> { get }
    /// Completion success method to get back an authorization token from a payment view
    var onTokenSuccess: ((String) -> Void)? { get set }
    /// Completion failure method to get back an error if the we failed to get an authorization token from a payment view
    var onTokenFailure: ((PrimerAPIError) -> Void)? { get set }

    func start(from presentingViewController: UIViewController)
}
