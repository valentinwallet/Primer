//
//  ApplePayCoordinator.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import Foundation
import UIKit
import PassKit

final class ApplePayCoordinator: NSObject {
    private let merchantId: String
    private var applePayController: PKPaymentAuthorizationViewController?

    weak var delegate: PaymentMethodCoordinatorDelegate?

    init(merchantId: String) {
        self.merchantId = merchantId
    }

    private func createApplePayView() -> UIView {
        let viewModel = ApplePayViewModel(merchantId: self.merchantId)
        let applePayView = ApplePayView(viewModel: viewModel)

        applePayView.delegate = self

        return applePayView
    }
}

// MARK: - PaymentMethodCoordinator
extension ApplePayCoordinator: PaymentMethodCoordinator {
    func start() -> UIView {
        return self.createApplePayView()
    }
}

// MARK: - Actions
extension ApplePayCoordinator {
    private func showApplePayAuthorizationViewController(for request: PKPaymentRequest) {
        self.applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        self.applePayController?.delegate = self

        if let topViewViewController = UIApplication.getTopViewController(),
           let applePayController = self.applePayController {
            topViewViewController.present(applePayController, animated: true, completion: nil)
        }
    }
}

// MARK: - ApplePayViewDelegate
extension ApplePayCoordinator: ApplePayViewDelegate {
    func applePayView(_ view: ApplePayView, DidPressApplePayButtonForPaymentRequest paymentRequest: PKPaymentRequest) {
        self.showApplePayAuthorizationViewController(for: paymentRequest)
    }
}

// MARK: - PKPaymentAuthorizationViewControllerDelegate
extension ApplePayCoordinator: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
