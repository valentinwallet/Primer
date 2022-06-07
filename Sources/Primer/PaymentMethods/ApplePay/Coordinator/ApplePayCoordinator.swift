//
//  ApplePayCoordinator.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import Foundation
import UIKit

final class ApplePayCoordinator {
    private let navigationController: UINavigationController
    private let merchantId: String

    weak var delegate: PaymentMethodCoordinatorDelegate?

    init(navigationController: UINavigationController,
         merchantId: String) {
        self.navigationController = navigationController
        self.merchantId = merchantId
    }

    private func createApplePayView() -> UIView {
        return UIView()
    }
}

// MARK: - PaymentMethodCoordinator
extension ApplePayCoordinator: PaymentMethodCoordinator {
    func start() -> UIView {
        return self.createApplePayView()
    }
}
