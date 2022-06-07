//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import XCTest
@testable import Primer

final class CardPaymentViewModelTests: XCTestCase {
    func test_initiate_payment_success() {
        // GIVEN
        let clientTokenService = ClientTokenServiceMock()
        let paymentInstrumentService = PaymentInstrumentServiceMock()
        let configuration = CheckoutBuilderConfiguration()
        let jwtDecoderService = JWTDecoderServiceMock()
        let viewModel = CardPaymentViewModel(configuration: configuration,
                                             clientTokenService: clientTokenService,
                                             paymentInstrumentService: paymentInstrumentService,
                                             jwtDecoderService: jwtDecoderService)
        let delegate = CardPaymentViewModelDelegateMock()
        let getClientTokenExpectation = self.expectation(description: "should call getClientTokenExpectation() method")
        let getPaymentTokenExpectation = self.expectation(description: "should call getPaymentTokenExpectation() method")
        let didFinishPaymentWithTokenExpectation = self.expectation(description: "should call didFinishPaymentWithTokenExpectation() delegate method")
        let getAccessTokenExpectation = self.expectation(description: "should call getAccessToken() method")

        viewModel.delegate = delegate
        delegate.didFinishPaymentWithTokenExpectation = didFinishPaymentWithTokenExpectation
        clientTokenService.getClientTokenExpectation = getClientTokenExpectation
        paymentInstrumentService.getPaymentTokenExpectation = getPaymentTokenExpectation
        jwtDecoderService.getAccessTokenExpectation = getAccessTokenExpectation


        // WHEN
        viewModel.initiatePayment(for: .mock())

        // THEN
        self.wait(for: [getClientTokenExpectation,
                        getAccessTokenExpectation,
                        getPaymentTokenExpectation,
                        didFinishPaymentWithTokenExpectation
                       ], timeout: 0.1, enforceOrder: true)
        XCTAssertEqual(delegate.token, "token")
    }

    func test_initiate_payment_payment_instrument_service_failure() {
        // GIVEN
        let clientTokenService = ClientTokenServiceMock()
        let paymentInstrumentService = PaymentInstrumentServiceMock(success: false)
        let configuration = CheckoutBuilderConfiguration()
        let jwtDecoderService = JWTDecoderServiceMock()
        let viewModel = CardPaymentViewModel(configuration: configuration,
                                             clientTokenService: clientTokenService,
                                             paymentInstrumentService: paymentInstrumentService,
                                             jwtDecoderService: jwtDecoderService)
        let delegate = CardPaymentViewModelDelegateMock()
        let getClientTokenExpectation = self.expectation(description: "should call getClientTokenExpectation() method")
        let getPaymentTokenExpectation = self.expectation(description: "should call getPaymentTokenExpectation() method")
        let didFailPaymentWithError = self.expectation(description: "should call didFailPaymentWithError() delegate method")
        let getAccessTokenExpectation = self.expectation(description: "should call getAccessToken() method")

        viewModel.delegate = delegate
        delegate.didFailPaymentWithError = didFailPaymentWithError
        clientTokenService.getClientTokenExpectation = getClientTokenExpectation
        paymentInstrumentService.getPaymentTokenExpectation = getPaymentTokenExpectation
        jwtDecoderService.getAccessTokenExpectation = getAccessTokenExpectation


        // WHEN
        viewModel.initiatePayment(for: .mock())

        // THEN
        self.wait(for: [getClientTokenExpectation,
                        getAccessTokenExpectation,
                        getPaymentTokenExpectation,
                        didFailPaymentWithError], timeout: 0.1, enforceOrder: true)
        XCTAssertEqual(delegate.error, .noResponse)
    }

    func test_initiate_payment_client_token_service_failure() {
        // GIVEN
        let clientTokenService = ClientTokenServiceMock(success: false)
        let paymentInstrumentService = PaymentInstrumentServiceMock()
        let configuration = CheckoutBuilderConfiguration()
        let jwtDecoderService = JWTDecoderServiceMock()
        let viewModel = CardPaymentViewModel(configuration: configuration,
                                             clientTokenService: clientTokenService,
                                             paymentInstrumentService: paymentInstrumentService,
                                             jwtDecoderService: jwtDecoderService)
        let delegate = CardPaymentViewModelDelegateMock()
        let getClientTokenExpectation = self.expectation(description: "should call getClientTokenExpectation() method")
        let didFailPaymentWithError = self.expectation(description: "should call didFailPaymentWithError() delegate method")

        viewModel.delegate = delegate
        delegate.didFailPaymentWithError = didFailPaymentWithError
        clientTokenService.getClientTokenExpectation = getClientTokenExpectation

        // WHEN
        viewModel.initiatePayment(for: .mock())

        // THEN
        self.wait(for: [getClientTokenExpectation,
                        didFailPaymentWithError], timeout: 0.1, enforceOrder: true)
        XCTAssertEqual(delegate.error, .unknown)
    }

    func test_initiate_payment_decode_service_failure() {
        // GIVEN
        let clientTokenService = ClientTokenServiceMock()
        let paymentInstrumentService = PaymentInstrumentServiceMock()
        let configuration = CheckoutBuilderConfiguration()
        let jwtDecoderService = JWTDecoderServiceMock(success: false)
        let viewModel = CardPaymentViewModel(configuration: configuration,
                                             clientTokenService: clientTokenService,
                                             paymentInstrumentService: paymentInstrumentService,
                                             jwtDecoderService: jwtDecoderService)
        let delegate = CardPaymentViewModelDelegateMock()
        let getClientTokenExpectation = self.expectation(description: "should call getClientTokenExpectation() method")
        let didFailPaymentWithError = self.expectation(description: "should call didFailPaymentWithError() delegate method")
        let getAccessTokenExpectation = self.expectation(description: "should call getAccessToken() method")

        viewModel.delegate = delegate
        delegate.didFailPaymentWithError = didFailPaymentWithError
        clientTokenService.getClientTokenExpectation = getClientTokenExpectation
        jwtDecoderService.getAccessTokenExpectation = getAccessTokenExpectation


        // WHEN
        viewModel.initiatePayment(for: .mock())

        // THEN
        self.wait(for: [getClientTokenExpectation,
                        getAccessTokenExpectation,
                        didFailPaymentWithError], timeout: 0.1, enforceOrder: true)
        XCTAssertEqual(delegate.error, .decode)
    }
}

private final class CardPaymentViewModelDelegateMock: CardPaymentViewModelDelegate {
    var didFinishPaymentWithTokenExpectation: XCTestExpectation?
    var didFailPaymentWithError: XCTestExpectation?
    var token: String?
    var error: PrimerAPIError?

    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFinishPaymentWithToken token: String) {
        self.token = token
        self.didFinishPaymentWithTokenExpectation?.fulfill()
    }

    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFailPaymentWithError error: PrimerAPIError) {
        self.error = error
        self.didFailPaymentWithError?.fulfill()
    }
}

private final class JWTDecoderServiceMock: JWTDecoderServiceProtocol {
    private let success: Bool

    var getAccessTokenExpectation: XCTestExpectation?

    init(success: Bool = true) {
        self.success = success
    }

    func getAccessToken(from token: String) -> String? {
        self.getAccessTokenExpectation?.fulfill()

        if self.success {
            return "accessToken"
        } else {
            return nil
        }
    }
}

private final class ClientTokenServiceMock: ClientTokenServiceProtocol {
    private let success: Bool

    var getClientTokenExpectation: XCTestExpectation?

    init(success: Bool = true) {
        self.success = success
    }

    func getClientToken(completion: @escaping (Result<ClientToken, PrimerAPIError>) -> Void) {
        self.getClientTokenExpectation?.fulfill()

        if self.success {
            completion(.success(ClientToken(clientToken: "accessToken", expirationDate: Date())))
        } else {
            completion(.failure(.unknown))
        }
    }
}

private final class PaymentInstrumentServiceMock: PaymentInstrumentServiceProtocol {
    private let success: Bool

    var getPaymentTokenExpectation: XCTestExpectation?

    init(success: Bool = true) {
        self.success = success
    }

    func getPaymentToken(for accessToken: String, cardDetails: CardDetails, completion: @escaping (Result<PaymentInstrumentResponse, PrimerAPIError>) -> Void) {
        self.getPaymentTokenExpectation?.fulfill()

        if self.success {
            completion(.success(PaymentInstrumentResponse(token: "token")))
        } else {
            completion(.failure(.noResponse))
        }
    }
}
