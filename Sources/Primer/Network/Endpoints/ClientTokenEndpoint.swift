//
//  ClientTokenEndpoint.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

struct ClientTokenEndpoint: Endpoint {
    let path: String = "/auth/client-token"
    let method: HTTPMethod = .post
    let body: Data? = nil
    let header: [String : String]? = [
        "X-Api-Key": "5a5d5931-ece2-4d29-a314-e0c374792ecb",
        "Content-Type": "Content-Type: application/json"
    ]
}
