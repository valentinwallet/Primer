//
//  PrimerAPIClient.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

protocol PrimerAPIClientProtocol {
    func sendRequest<T: Decodable>(endpoint: Endpoint, model: T.Type, completion: @escaping (Result<T, PrimerAPIError>) -> Void)
}

final class PrimerAPIClient: PrimerAPIClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func sendRequest<T: Decodable>(endpoint: Endpoint, model: T.Type, completion: @escaping (Result<T, PrimerAPIError>) -> Void) {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        self.urlSession.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(.unknown))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedModel = try? PrimerJSONDecoder().decode(model, from: data) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(decodedModel))
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
