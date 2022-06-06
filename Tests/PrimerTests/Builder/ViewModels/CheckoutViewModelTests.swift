//
//  CheckoutViewModelTests.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import XCTest
@testable import Primer

final class CheckoutViewModelTests: XCTestCase {
    func test_get_payment_method_views() {
        // GIVEN
        let viewModel = CheckoutViewModel(configuration: CheckoutBuilderConfiguration(), paymentMethods: [.card])

        // WHEN
        let paymentMethodViews = viewModel.getPaymentMethodViews()

        // THEN
        XCTAssertEqual(paymentMethodViews.count, 1, "Should have one payment method view")
        XCTAssertTrue(paymentMethodViews[0] is CardPaymentView)
    }
}
