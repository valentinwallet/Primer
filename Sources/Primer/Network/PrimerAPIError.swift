//
//  PrimerAPIError.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

enum PrimerAPIError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
