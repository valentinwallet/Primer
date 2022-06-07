//
//  JWTDecoderService.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import JWTDecode

protocol JWTDecoderServiceProtocol {
    func getAccessToken(from token: String) -> String?
}

final class JWTDecoderService: JWTDecoderServiceProtocol {
    func getAccessToken(from jwt: String) -> String? {
        guard let jwt = try? decode(jwt: jwt) else {
            return nil
        }

        if let accessToken = jwt.body["accessToken"] as? String {
            return accessToken
        } else {
            return nil
        }
    }
}
