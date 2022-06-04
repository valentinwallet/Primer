//
//  ExpiryDateTextFieldViewModelTests.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit
import XCTest
@testable import Primer

final class ExpiryDateTextFieldViewModelTests: XCTestCase {
    func test_title() {
        // GIVEN
        let viewModel = ExpiryDateTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.title, "Expiry Date")
    }

    func test_keyboard_type() {
        // GIVEN
        let viewModel = ExpiryDateTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.keyboardType, .numberPad)
    }

    func test_should_change_characters() {
        // GIVEN
        let viewModel = ExpiryDateTextFieldViewModel()
        let testData: [(textFieldCurrentText: String, replacementString: String, range: NSRange, expectedText: String, expectedResult: Bool)] = [
            ("", "2", NSRange(location: 0, length: 0), "", false),
            ("", "1", NSRange(location: 0, length: 0), "", true),
            ("1", "2", NSRange(location: 1, length: 0), "12/", false),
            ("12/", "2", NSRange(location: 3, length: 0), "12/", true),
            ("12/2", "3", NSRange(location: 4, length: 0), "12/2", true),
            ("12/23", "3", NSRange(location: 5, length: 0), "12/23", false),
        ]

        // WHEN
        testData.forEach { (textFieldCurrentText: String, replacementString: String, range: NSRange, expectedText: String, expectedResult: Bool) in
            let textField = UITextField()
            textField.text = textFieldCurrentText
            // THEN
            XCTAssertEqual(
                viewModel.shouldChangeCharacters(textField: textField, range: range, replacementString: replacementString),
                expectedResult,
                "wrong expected result for textField current text: \(textFieldCurrentText), replacementString: \(replacementString), range: \(range)"
            )
            XCTAssertEqual(textField.text, expectedText, "wrong textfield text")
        }
    }
}
