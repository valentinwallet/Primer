//
//  PaymentMethod.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

/// `PaymentMethod` is useful in order to create the differents
/// `PaymentView` for the `CheckoutBaseViewController`
public enum PaymentMethod {
    case card
    case applePay(merchantId: String)
}

extension PaymentMethod: Equatable {}
