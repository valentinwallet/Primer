//
//  CardDetails.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

struct PaymentInstrument: Encodable {
    let cardDetails: CardDetails

    enum CodingKeys: String, CodingKey {
        case cardDetails = "paymentInstrument"
    }
}

struct CardDetails: Encodable {
    let number: String
    let cvv: String
    let expirationMonth: String
    let expirationYear: String
    let cardholderName: String
}
