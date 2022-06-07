//
//  PaymentMethodCoordinatorDelegateMock.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

@testable import Primer
import XCTest

final class PaymentMethodCoordinatorDelegateMock: PaymentMethodCoordinatorDelegate {
    var didAuthorizePaymentMethodForTokenExpectation: XCTestExpectation?
    var didFailAuthorizePaymentMethodWithErrorExpectation: XCTestExpectation?
    var token: String?
    var error: PrimerAPIError?

    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didAuthorizePaymentMethodForToken token: String) {
        self.token = token
        self.didAuthorizePaymentMethodForTokenExpectation?.fulfill()
    }

    func paymentMethodCoordinator(_ coordinator: PaymentMethodCoordinator, didFailAuthorizePaymentMethodWithError error: PrimerAPIError) {
        self.error = error
        self.didFailAuthorizePaymentMethodWithErrorExpectation?.fulfill()
    }
}
