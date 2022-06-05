//
//  PrimerAPIClientMock.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import XCTest
@testable import Primer

final class PrimerAPIClientMock<U: Decodable>: PrimerAPIClientProtocol {
    var sendRequestExpectation: XCTestExpectation?
    var endpoint: Endpoint?
    var decodableObject: U?

    func sendRequest<T>(endpoint: Endpoint, model: T.Type, completion: @escaping (Result<T, PrimerAPIError>) -> Void) where T : Decodable {
        self.endpoint = endpoint

        if let decodableObject = decodableObject as? T {
            completion(.success(decodableObject))
        } else {
            completion(.failure(.unknown))
        }

        self.sendRequestExpectation?.fulfill()
    }
}
