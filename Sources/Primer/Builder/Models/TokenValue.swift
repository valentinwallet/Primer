//
//  TokenValue.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

public enum TokenValue {
    case success(token: String)
    case failure(error: PrimerAPIError)
}
