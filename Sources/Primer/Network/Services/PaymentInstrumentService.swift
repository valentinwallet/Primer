//
//  PaymentInstrumentService.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

final class PaymentInstrumentService {
    private let primerAPIClient: PrimerAPIClientProtocol

    init(primerAPIClient: PrimerAPIClientProtocol = PrimerAPIClient()) {
        self.primerAPIClient = primerAPIClient
    }

    func getPaymentToken(for accessToken: String, paymentInstrument: PaymentInstrument, completion: @escaping (Result<PaymentInstrumentResponse, PrimerAPIError>) -> Void) {
        self.primerAPIClient.sendRequest(endpoint: PaymentInstrumentEndpoint(accessToken: accessToken, paymentInstrument: paymentInstrument), model: PaymentInstrumentResponse.self) { result in
            completion(result)
        }
    }
}
