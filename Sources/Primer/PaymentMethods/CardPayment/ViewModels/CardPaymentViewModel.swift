//
//  CardPaymentViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation
import JWTDecode

protocol CardPaymentViewModelDelegate: AnyObject {
    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFinishPaymentWithToken token: String)
    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFailPaymentWithError error: PrimerAPIError)
}

final class CardPaymentViewModel {
    private let clientTokenService: ClientTokenServiceProtocol
    private let paymentInstrumentService: PaymentInstrumentServiceProtocol

    private(set) var configuration: CheckoutBuilderConfiguration

    weak var delegate: CardPaymentViewModelDelegate?

    init(configuration: CheckoutBuilderConfiguration,
         clientTokenService: ClientTokenServiceProtocol = ClientTokenService(),
         paymentInstrumentService: PaymentInstrumentServiceProtocol = PaymentInstrumentService()) {
        self.configuration = configuration
        self.clientTokenService = clientTokenService
        self.paymentInstrumentService = paymentInstrumentService
    }

    func initiatePayment(for cardDetails: CardDetails) {
        self.clientTokenService.getClientToken { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let clientToken):
                self.handleClientToken(clientToken, for: cardDetails)
            case .failure(let error):
                self.delegate?.cardPaymentViewModel(self, didFailPaymentWithError: error)
            }
        }
    }

    private func handleClientToken(_ clientToken: ClientToken, for cardDetails: CardDetails) {
        guard let accessToken = self.getAccessToken(from: clientToken) else {
            self.delegate?.cardPaymentViewModel(self, didFailPaymentWithError: .decode)
            return
        }

        self.paymentInstrumentService
            .getPaymentToken(for: accessToken, cardDetails: cardDetails) { [weak self] in
                self?.handlePaymentInstrumentServiceResult($0)
            }
    }

    private func handlePaymentInstrumentServiceResult(_ result: Result<PaymentInstrumentResponse, PrimerAPIError>) {
        switch result {
        case .success(let paymentInstrumentResponse):
            self.delegate?.cardPaymentViewModel(self, didFinishPaymentWithToken: paymentInstrumentResponse.token)
        case .failure(let error):
            self.delegate?.cardPaymentViewModel(self, didFailPaymentWithError: error)
        }
    }

    private func getAccessToken(from clientToken: ClientToken) -> String? {
        guard let jwt = try? decode(jwt: clientToken.clientToken) else {
            return nil
        }

        if let accessToken = jwt.body["accessToken"] as? String {
            return accessToken
        } else {
            return nil
        }
    }
}
