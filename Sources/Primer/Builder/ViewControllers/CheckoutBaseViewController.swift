//
//  CheckoutBaseViewController.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import Combine
import UIKit

/// Delegate for `CheckoutBaseViewController`
public protocol CheckoutViewControllerDelegate: AnyObject {
    func checkoutViewController(_ viewController: CheckoutViewControllerProtocol, didAuthorizePaymentForToken token: String)
    func checkoutViewController(_ viewController: CheckoutViewControllerProtocol, didFailPaymentWithError error: PrimerAPIError)
}

/// Protocol with the different methods in order to get a valid token from a payment.
/// Three choices are available: delegate, publisher or a completion.
public protocol CheckoutViewControllerProtocol: AnyObject {
    var delegate: CheckoutViewControllerDelegate? { get set }
    var tokenPublisher: AnyPublisher<TokenValue, Never> { get }
    var onTokenSuccess: ((String) -> Void)? { get set }
    var onTokenFailure: ((PrimerAPIError) -> Void)? { get set }
}

/// Combination of a `UIViewController` and `CheckoutViewControllerProtocol`
public typealias CheckoutBaseViewController = UIViewController & CheckoutViewControllerProtocol
