//
//  CheckoutBaseViewController.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import Combine
import UIKit

public protocol CheckoutViewControllerDelegate: AnyObject {
    func checkoutViewController(_ viewController: CheckoutViewControllerProtocol, didAuthorizePaymentForToken token: String)
    func checkoutViewController(_ viewController: CheckoutViewControllerProtocol, didFailPaymentWithError error: PrimerAPIError)
}

public protocol CheckoutViewControllerProtocol: AnyObject {
    var delegate: CheckoutViewControllerDelegate? { get set }
    var publisher: AnyPublisher<TokenValue, Never> { get }
    var completion: ((Result<String, PrimerAPIError>) -> Void)? { get set }
}

public typealias CheckoutBaseViewController = UIViewController & CheckoutViewControllerProtocol
