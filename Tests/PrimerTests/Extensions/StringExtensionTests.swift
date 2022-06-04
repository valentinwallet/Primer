//
//  StringExtensionTests.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import XCTest
@testable import Primer

final class StringExtensionTests: XCTestCase {
    func test_only_contains_letter() {
        // GIVEN
        let testData: [(string: String, expectedResult: Bool)] = [
            ("", false),
            ("abc123", false),
            ("231", false),
            ("jfiejwfwe", true),
            ("fijfoiweDEOJJ", true)
        ]

        // WHEN
        testData.forEach { (string: String, expectedResult: Bool) in
            // THEN
            XCTAssertEqual(string.onlyContainsLetters, expectedResult, "wrong result for string: \(string), should be: \(expectedResult)")
        }
    }

    func test_only_contains_numbers() {
        // GIVEN
        let testData: [(string: String, expectedResult: Bool)] = [
            ("", false),
            ("abc123", false),
            ("abc", false),
            ("123", true),
            ("321342423", true)
        ]

        // WHEN
        testData.forEach { (string: String, expectedResult: Bool) in
            XCTAssertEqual(string.onlyContainsNumbers, expectedResult, "wrong result for string: \(string), should be: \(expectedResult)")
        }
    }

    func test_remove_whitespace() {
        // GIVEN
        let testData: [(string: String, expectedResult: String)] = [
            ("", ""),
            ("abc123", "abc123"),
            ("abc abc", "abcabc"),
            ("Hello world !", "Helloworld!")
        ]

        // WHEN
        testData.forEach { (string: String, expectedResult: String) in
            XCTAssertEqual(string.removeWhitespaces, expectedResult, "wrong result for string: \(string), should be: \(expectedResult)")
        }
    }
}
