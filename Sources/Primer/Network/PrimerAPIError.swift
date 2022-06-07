//
//  PrimerAPIError.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

/// Enum to manage the different error that can happen when calling `PrimerAPIClient`
public enum PrimerAPIError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}
