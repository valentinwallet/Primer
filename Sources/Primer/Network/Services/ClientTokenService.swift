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
    private let userDefaults: UserDefaults
    private let userDefaultsTokenKey: String = "ClientToken"

    init(primerAPIClient: PrimerAPIClientProtocol = PrimerAPIClient(),
         userDefaults: UserDefaults = .standard) {
        self.primerAPIClient = primerAPIClient
        self.userDefaults = userDefaults
    }

    func getClientToken(completion: @escaping (Result<ClientToken, PrimerAPIError>) -> Void) {
        if let token = self.getValidToken() {
            completion(.success(token))
        } else {
            self.primerAPIClient.sendRequest(endpoint: ClientTokenEndpoint(), model: ClientToken.self) { result in
                if case .success(let token) = result {
                    self.store(clientToken: token)
                }
                completion(result)
            }
        }
    }

    private func store(clientToken: ClientToken) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(.millisecondsFormatter)
        let encodedToken = try? jsonEncoder.encode(clientToken)
        self.userDefaults.set(encodedToken, forKey: "ClientToken")
    }

    private func getValidToken() -> ClientToken? {
        guard let clientTokenData = self.userDefaults.data(forKey: self.userDefaultsTokenKey) else {
            return nil
        }

        guard let token = try? PrimerJSONDecoder().decode(ClientToken.self, from: clientTokenData) else {
            return nil
        }

        return token.expirationDate > Date() ? token : nil
    }
}
