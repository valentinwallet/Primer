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

    func test_validate() {
        // GIVEN
        let viewModel = CardHolderNameTextFieldViewModel()
        let testData: [(text: String, expectedResult: Bool)] = [
            ("", false),
            ("132", false),
            ("abc123", false),
            ("John Doe", true)
        ]

        // WHEN
        testData.forEach { (text: String, expectedResult: Bool) in
            // THEN
            XCTAssertEqual(viewModel.validate(for: text), expectedResult, "wrong validate value for text: \(text) should be \(expectedResult)")
        }
    }
}
