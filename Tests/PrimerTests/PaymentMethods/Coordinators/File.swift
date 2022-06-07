//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import XCTest
@testable import Primer

final class CardPaymentCoordinatorTests: XCTestCase {
    func test_start() {
        // GIVEN
        let coordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())

        // WHEN...THEN
        XCTAssertTrue(coordinator.start() is CardPaymentView)
    }

    func test_delegate_success() {
        // GIVEN
        let configuration = CheckoutBuilderConfiguration()
        let coordinator = CardPaymentCoordinator(configuration: configuration)
        let delegate = PaymentMethodCoordinatorDelegateMock()
        let didAuthorizePaymentMethodForTokenExpectation = self.expectation(description: "should call didAuthorizePaymentMethodForTokenExpectation() delegate method")

        coordinator.delegate = delegate
        delegate.didAuthorizePaymentMethodForTokenExpectation = didAuthorizePaymentMethodForTokenExpectation

        // WHEN
        coordinator.cardPaymentView(CardPaymentView(viewModel: CardPaymentViewModel(configuration: configuration)), didAuthorizePaymentMethodForToken: "token")

        // THEN
        self.wait(for: [didAuthorizePaymentMethodForTokenExpectation], timeout: 0.1)
        XCTAssertEqual(delegate.token, "token")
    }

    func test_delegate_failure() {
        // GIVEN
        let configuration = CheckoutBuilderConfiguration()
        let coordinator = CardPaymentCoordinator(configuration: configuration)
        let delegate = PaymentMethodCoordinatorDelegateMock()
        let didFailAuthorizePaymentMethodWithErrorExpectation = self.expectation(description: "should call didFailAuthorizePaymentMethodWithErrorExpectation() delegate method")

        coordinator.delegate = delegate
        delegate.didFailAuthorizePaymentMethodWithErrorExpectation = didFailAuthorizePaymentMethodWithErrorExpectation

        // WHEN
        coordinator.cardPaymentView(CardPaymentView(viewModel: CardPaymentViewModel(configuration: configuration)), didFailAuthorizePaymentMethodWithError: .decode)

        // THEN
        self.wait(for: [didFailAuthorizePaymentMethodWithErrorExpectation], timeout: 0.1)
        XCTAssertEqual(delegate.error, .decode)
    }
}
