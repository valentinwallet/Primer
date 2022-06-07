//
//  CheckoutCoordinatorProtocol.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import Combine
import UIKit

/// Delegate for `CheckoutBuilderCoordinator`
public protocol CheckoutBuilderCoordinatorDelegate: AnyObject {
    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didAuthorizeMethodPaymentForToken token: String)
    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didFailAuthorizePaymentMethodWithError error: PrimerAPIError)
}

/// Protocol with the different methods in order to get a valid token from a payment.
/// Three choices are available: delegate, publisher or a completion.
public protocol CheckoutCoordinatorProtocol: AnyObject {
    var delegate: CheckoutBuilderCoordinatorDelegate? { get set }
    var tokenPublisher: AnyPublisher<TokenValue, Never> { get }
    var onTokenSuccess: ((String) -> Void)? { get set }
    var onTokenFailure: ((PrimerAPIError) -> Void)? { get set }

    func start(from presentingViewController: UIViewController)
}
