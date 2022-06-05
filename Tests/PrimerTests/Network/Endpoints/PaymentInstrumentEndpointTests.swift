//
//  PaymentInstrumentEndpointTests.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import XCTest
@testable import Primer

final class PaymentInstrumentEndpointTests: XCTestCase {
    func test_path() {
        // GIVEN
        let endpoint = self.createPaymentInstrumentEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.path, "/payment-instruments")
    }

    func test_http_method() {
        // GIVEN
        let endpoint = self.createPaymentInstrumentEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.method, .post)
    }

    func test_body() throws {
        // GIVEN
        let endpoint = self.createPaymentInstrumentEndpoint()
        let body = try XCTUnwrap(endpoint.body as? [String: [String: String]])

        // WHEN...THEN
        XCTAssertEqual(body, [
            "paymentInstrument": [
                "number": "4111111111111111",
                "cvv": "737",
                "expirationMonth": "03",
                "expirationYear": "2030",
                "cardholderName": "J Doe",
            ]
        ])
    }

    func test_header() {
        // GIVEN
        let endpoint = self.createPaymentInstrumentEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.header, [
            "Content-Type": "application/json",
            "Primer-Client-Token": "accessToken"
        ])
    }

    func test_base_url() {
        // GIVEN
        let endpoint = self.createPaymentInstrumentEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.baseURL, "https://sdk.api.staging.primer.io")
    }

    private func createPaymentInstrumentEndpoint() -> PaymentInstrumentEndpoint {
        return PaymentInstrumentEndpoint(accessToken: "accessToken",
                                         cardDetails: .mock())
    }
}
