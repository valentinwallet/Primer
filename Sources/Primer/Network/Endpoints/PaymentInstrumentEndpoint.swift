//
//  PaymentInstrumentEndpoint.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

struct PaymentInstrumentEndpoint: Endpoint {
    let path: String = "/payment-instruments"
    let method: HTTPMethod = .post
    var header: [String: String]?
    var body: Data? = nil

    init(accessToken: String, paymentInstrument: PaymentInstrument) {
        self.header = [
            "Primer-Client-Token": accessToken,
            "Content-Type": "Content-Type: application/json"
        ]
        
        self.body = try? JSONEncoder().encode(paymentInstrument)
    }
}
