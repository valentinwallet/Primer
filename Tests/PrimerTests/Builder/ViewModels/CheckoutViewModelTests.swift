//
//  CheckoutViewModelTests.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import XCTest
@testable import Primer

final class CheckoutViewModelTests: XCTestCase {
    func test_title() {
        // GIVEN
        let viewModel = CheckoutViewModel(paymentMethodSectionViews: [])

        // THEN
        XCTAssertEqual(viewModel.title, "Checkout")
    }
}
