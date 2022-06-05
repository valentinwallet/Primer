//
//  ClientTokenEndpointTests.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import XCTest
@testable import Primer

final class ClientTokenEndpointTests: XCTestCase {
    func test_path() {
        // GIVEN
        let endpoint = ClientTokenEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.path, "/auth/client-token")
    }

    func test_http_method() {
        // GIVEN
        let endpoint = ClientTokenEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.method, .post)
    }

    func test_body() {
        // GIVEN
        let endpoint = ClientTokenEndpoint()

        // WHEN...THEN
        XCTAssertNil(endpoint.body)
    }

    func test_header() {
        // GIVEN
        let endpoint = ClientTokenEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.header, [
            "X-Api-Key": "5a5d5931-ece2-4d29-a314-e0c374792ecb",
            "Content-Type": "Content-Type: application/json"
        ])
    }

    func test_base_url() {
        // GIVEN
        let endpoint = ClientTokenEndpoint()

        // WHEN...THEN
        XCTAssertEqual(endpoint.baseURL, "https://api.staging.primer.io")
    }
}
