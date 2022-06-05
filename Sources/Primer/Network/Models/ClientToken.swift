//
//  ClientToken.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

struct ClientToken: Codable {
    let clientToken: String
    let expirationDate: Date
}
