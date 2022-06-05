//
//  ClientTokenServiceTests.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import XCTest
@testable import Primer

final class ClientTokenServiceTests: XCTestCase {
    private let userDefaults: UserDefaults? = UserDefaults(suiteName: "ClientTokenServiceTests")

    override func setUp() {
        super.setUp()

        self.userDefaults?.removePersistentDomain(forName: "ClientTokenServiceTests")
    }

    func test_send_request_endpoint() throws {
        // GIVEN
        let primerAPIClientMock = PrimerAPIClientMock<ClientToken>()
        let userDefaults = try XCTUnwrap(self.userDefaults)
        let clientTokenService = ClientTokenService(primerAPIClient: primerAPIClientMock, userDefaults: userDefaults)
        let sendRequestExpectation = self.expectation(description: "should call sendRequest() method")

        primerAPIClientMock.sendRequestExpectation = sendRequestExpectation

        // WHEN
        clientTokenService.getClientToken { _ in }

        // THEN
        self.wait(for: [sendRequestExpectation], timeout: 0.1)
        XCTAssertTrue(primerAPIClientMock.endpoint is ClientTokenEndpoint)
    }

    func test_get_client_token_user_data_empty() throws {
        // GIVEN
        let primerAPIClientMock = PrimerAPIClientMock<ClientToken>()
        let userDefaults = try XCTUnwrap(self.userDefaults)
        let clientTokenService = ClientTokenService(primerAPIClient: primerAPIClientMock, userDefaults: userDefaults)
        let sendRequestExpectation = self.expectation(description: "should call sendRequest() method")
        let dateOfTommorow = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: 1, to: Date()))

        primerAPIClientMock.sendRequestExpectation = sendRequestExpectation
        primerAPIClientMock.decodableObject = ClientToken(clientToken: "token", expirationDate: dateOfTommorow)

        // WHEN
        clientTokenService.getClientToken { result in
            switch result {
            case .failure(_):
                XCTFail("should not fail")
            case .success(let token):
                XCTAssertEqual(token.clientToken, "token", "wrong token")
            }
        }

        // THEN
        self.wait(for: [sendRequestExpectation], timeout: 0.1)
        XCTAssertNotNil(userDefaults.data(forKey: "ClientToken"))
    }

    func test_get_client_token_user_data_filled() throws {
        // GIVEN
        let primerAPIClientMock = PrimerAPIClientMock<ClientToken>()
        let userDefaults = try XCTUnwrap(self.userDefaults)
        let clientTokenService = ClientTokenService(primerAPIClient: primerAPIClientMock, userDefaults: userDefaults)
        let sendRequestExpectation = self.expectation(description: "should call sendRequest() method")
        let dateOfTommorow = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: 1, to: Date()))

        sendRequestExpectation.expectedFulfillmentCount = 1
        primerAPIClientMock.sendRequestExpectation = sendRequestExpectation
        primerAPIClientMock.decodableObject = ClientToken(clientToken: "token", expirationDate: dateOfTommorow)

        // WHEN
        clientTokenService.getClientToken { _ in }
        clientTokenService.getClientToken { result in
            switch result {
            case .failure(_):
                XCTFail("should not fail")
            case .success(let token):
                XCTAssertEqual(token.clientToken, "token", "wrong token")
            }
        }

        // THEN
        self.wait(for: [sendRequestExpectation], timeout: 0.1)
        XCTAssertNotNil(userDefaults.data(forKey: "ClientToken"))
    }

    func test_get_client_token_failure_not_stored() throws {
        // GIVEN
        let primerAPIClientMock = PrimerAPIClientMock<ClientToken>()
        let userDefaults = try XCTUnwrap(self.userDefaults)
        let clientTokenService = ClientTokenService(primerAPIClient: primerAPIClientMock, userDefaults: userDefaults)
        let sendRequestExpectation = self.expectation(description: "should call sendRequest() method")

        primerAPIClientMock.sendRequestExpectation = sendRequestExpectation

        // WHEN
        clientTokenService.getClientToken { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknown, "wrong error type")
            case .success(_):
                XCTFail("should not succeed")
            }
        }

        // THEN
        self.wait(for: [sendRequestExpectation], timeout: 0.1)
        XCTAssertNil(userDefaults.data(forKey: "ClientToken"))
    }
}
