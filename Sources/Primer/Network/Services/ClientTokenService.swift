//
//  ClientTokenService.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

protocol ClientTokenServiceProtocol: AnyObject {
    func getClientToken(completion: @escaping (Result<ClientToken, PrimerAPIError>) -> Void)
}

final class ClientTokenService: ClientTokenServiceProtocol {
    private let primerAPIClient: PrimerAPIClientProtocol

    init(primerAPIClient: PrimerAPIClientProtocol = PrimerAPIClient()) {
        self.primerAPIClient = primerAPIClient
    }

    func getClientToken(completion: @escaping (Result<ClientToken, PrimerAPIError>) -> Void) {
        self.primerAPIClient.sendRequest(endpoint: ClientTokenEndpoint(), model: ClientToken.self) { result in
            completion(result)
        }
    }
}
