//
//  CCVTextFieldViewModelTests.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import XCTest
import UIKit
@testable import Primer

final class CCVTextFieldViewModelTests: XCTestCase {
    func test_title() {
        // GIVEN
        let viewModel = CCVTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.title, "CCV Code")
    }

    func test_keyboard_type() {
        // GIVEN
        let viewModel = CCVTextFieldViewModel()

        // WHEN...THEN
        XCTAssertEqual(viewModel.keyboardType, .numberPad)
    }

    func test_should_change_characters() {
        // GIVEN
        let viewModel = CCVTextFieldViewModel()
        let testData: [(textFieldCurrentText: String, replacementString: String, range: NSRange, expectedResult: Bool)] = [
            ("", "", NSRange(location: -1, length: 0), false),
            ("", "2", NSRange(location: 0, length: 0), true),
            ("1", "2", NSRange(location: 1, length: 0), true),
            ("12", "3", NSRange(location: 2, length: 0), true),
            ("123", "4", NSRange(location: 3, length: 0), true),
            ("1234", "5", NSRange(location: 4, length: 0), false)
        ]

        // WHEN
        testData.forEach { (textFieldCurrentText: String, replacementString: String, range: NSRange, expectedResult: Bool) in
            let testTextField = UITextField()
            testTextField.text = textFieldCurrentText
            // THEN
            XCTAssertEqual(
                viewModel.shouldChangeCharacters(textField: testTextField, range: range, replacementString: replacementString),
                expectedResult,
                "wrong expected result for textField current text: \(textFieldCurrentText), replacementString: \(replacementString), range: \(range) ")
        }
    }
}
