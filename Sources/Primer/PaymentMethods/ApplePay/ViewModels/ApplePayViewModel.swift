//
//  ApplePayViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit
import PassKit

final class ApplePayViewModel {
    private(set) var merchantId: String

    init(merchantId: String) {
        self.merchantId = merchantId
    }

    func getPaymentRequest() -> PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = self.merchantId
        request.supportedNetworks = [.visa, .masterCard,.amex,.discover]
        request.supportedCountries = ["FR"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "FR"
        request.currencyCode = "EUR"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Test apple pay", amount: 1)]
        return request
    }
}
