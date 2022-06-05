//
//  PaymentInstrumentEndpoint.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

struct PaymentInstrumentEndpoint: Endpoint {
    let baseURL: String = "https://sdk.api.staging.primer.io"
    let path: String = "/payment-instruments"
    let method: HTTPMethod = .post
    var header: [String: String]?
    var body: [String: Any]?

    init(accessToken: String, cardDetails: CardDetails) {
        self.header = [
            "Content-Type": "application/json",
            "Primer-Client-Token": accessToken
        ]
        
        self.body = [
            "paymentInstrument": [
                "number": cardDetails.number,
                "cvv": cardDetails.cvv,
                "expirationMonth": cardDetails.expirationMonth,
                "expirationYear": cardDetails.expirationYear,
                "cardholderName": cardDetails.cardholderName
            ]
        ]
    }
}
