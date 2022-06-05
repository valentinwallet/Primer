//
//  Endpoint.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.staging.primer.io"
    }
}

