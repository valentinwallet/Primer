//
//  CardNumberTextFieldViewModelTests.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import XCTest
import UIKit
@testable import Primer

final class CardNumberTextFieldViewModelTests: XCTestCase {
    func test_title() {
        // GIVEN
        let viewModel = CardNumberTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.title, "Card Number")
    }

    func test_keyboard_type() {
        // GIVEN
        let viewModel = CardHolderNameTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.keyboardType, .default)
    }

    func test_validate() {
        // GIVEN
        let viewModel = CardNumberTextFieldViewModel()
        let testData: [(text: String, expectedResult: Bool)] = [
            ("", false),
            ("132", true),
            ("1334 3213 3213 3213", true),
            ("1234 abc", false),
            ("abc", false)
        ]

        // WHEN
        testData.forEach { (text: String, expectedResult: Bool) in
            // THEN
            XCTAssertEqual(viewModel.validate(for: text), expectedResult, "wrong validate value for text: \(text) should be \(expectedResult)")
        }
    }
}
