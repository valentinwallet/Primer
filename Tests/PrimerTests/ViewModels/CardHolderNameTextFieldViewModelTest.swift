//
//  CardHolderNameTextFieldViewModelTest.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import XCTest
import UIKit
@testable import Primer

final class CardHolderNameTextFieldViewModelTest: XCTestCase {
    func test_title() {
        // GIVEN
        let viewModel = CardHolderNameTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.title, "Cardholder Name")
    }

    func test_keyboard_type() {
        // GIVEN
        let viewModel = CardHolderNameTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.keyboardType, .default)
    }
}
