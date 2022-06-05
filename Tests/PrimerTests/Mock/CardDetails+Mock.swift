//
//  CardDetails+Mock.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

@testable import Primer

extension CardDetails {
    static func mock() -> CardDetails {
        return CardDetails(number: "4111111111111111",
                                 cvv: "737",
                                 expirationMonth: "03",
                                 expirationYear: "2030",
                                 cardholderName: "J Doe")
    }
}
