//
//  TokenValue.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

/// Return value for `tokenPublisher` on `CheckoutBaseViewController`.
/// Return a token in case of a success and a `PrimerAPIError` in case of a failure.
public enum TokenValue {
    case success(token: String)
    case failure(error: PrimerAPIError)
}
