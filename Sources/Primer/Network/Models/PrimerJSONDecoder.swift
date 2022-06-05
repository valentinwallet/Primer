//
//  PrimerJSONDecoder.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

final class PrimerJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(.milliseconds)
    }
}
