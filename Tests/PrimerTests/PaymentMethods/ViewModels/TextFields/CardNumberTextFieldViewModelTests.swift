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

    func test_text_field_did_change() {
        // GIVEN
        let viewModel = CardNumberTextFieldViewModel()
        let testData: [(text: String, expectedResult: String)] = [
            ("1234", "1234"),
            ("13256", "1325 6"),
            ("4111411141114111", "4111 4111 4111 4111")
        ]

        // WHEN
        testData.forEach { (text: String, expectedResult: String) in
            let textField = UITextField()
            textField.text = text
            viewModel.textFieldDidChange(textField: textField)

            // THEN
            XCTAssertEqual(textField.text, expectedResult, "wrong textFieldText, should be \(expectedResult) for \(text)")
        }
    }
}
