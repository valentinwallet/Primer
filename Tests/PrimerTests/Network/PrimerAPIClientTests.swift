//
//  PrimerAPIClientTests.swift
//  
//
//  Created by Valentin Wallet on 6/8/22.
//

import XCTest
@testable import Primer

final class PrimerAPIClientTests: XCTestCase {
    func test_send_request() throws {
        // GIVEN
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let primerAPIClient = PrimerAPIClient(urlSession: urlSession)
        let testString = "Hello, World !"
        let mockData = try JSONEncoder().encode(testString)
        let sendRequestCompletionExpectation = self.expectation(description: "should fulfill when completion is called")

        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }

        // WHEN
        primerAPIClient.sendRequest(endpoint: ClientTokenEndpoint(), model: String.self) { result in
            sendRequestCompletionExpectation.fulfill()
            // THEN
            switch result {
            case .success(let string):
                XCTAssertEqual(string, "Hello, World !")
            case .failure(_):
                XCTFail("should not be a failure")
            }
        }

        self.wait(for: [sendRequestCompletionExpectation], timeout: 0.1)
    }
}
