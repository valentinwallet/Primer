//
//  PaymentInstrumentServiceTests.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import XCTest
@testable import Primer

final class PaymentInstrumentServiceTests: XCTestCase {
    func test_get_payment_token_send_request_is_called() {
        // GIVEN
        let primerAPIClientMockService = PrimerAPIClientMock<PaymentInstrumentResponse>()
        let service = PaymentInstrumentService(primerAPIClient: primerAPIClientMockService)
        let sendRequestExpectation = self.expectation(description: "should call sendRequest()")

        primerAPIClientMockService.sendRequestExpectation = sendRequestExpectation

        // WHEN
        service.getPaymentToken(for: "accessToken", cardDetails: .mock()) { _ in }

        // THEN
        self.wait(for: [sendRequestExpectation], timeout: 0.1)
    }

    func test_get_payment_token_send_request_endpoint() {
        // GIVEN
        let primerAPIClientMockService = PrimerAPIClientMock<PaymentInstrumentResponse>()
        let service = PaymentInstrumentService(primerAPIClient: primerAPIClientMockService)

        // WHEN
        service.getPaymentToken(for: "accessToken", cardDetails: .mock()) { _ in }

        // THEN
        XCTAssertTrue(primerAPIClientMockService.endpoint is PaymentInstrumentEndpoint)
    }

    func test_get_payment_token_success() {
        // GIVEN
        let primerAPIClientMockService = PrimerAPIClientMock<PaymentInstrumentResponse>()
        let service = PaymentInstrumentService(primerAPIClient: primerAPIClientMockService)

        primerAPIClientMockService.decodableObject = PaymentInstrumentResponse(token: "token")

        // WHEN
        service.getPaymentToken(for: "accessToken", cardDetails: .mock()) { result in
            // THEN
            switch result {
            case .success(let response):
                XCTAssertEqual(response.token, "token")
            case .failure(_):
                XCTFail("should not be a failure")
            }
        }
    }

    func test_get_payment_token_failure() {
        // GIVEN
        let primerAPIClientMockService = PrimerAPIClientMock<PaymentInstrumentResponse>()
        let service = PaymentInstrumentService(primerAPIClient: primerAPIClientMockService)

        // WHEN
        service.getPaymentToken(for: "accessToken", cardDetails: .mock()) { result in
            // THEN
            switch result {
            case .success(_):
                XCTFail("should not be a success")
            case .failure(let error):
                XCTAssertEqual(error, .unknown, "wrong error type")
            }
        }
    }
}
