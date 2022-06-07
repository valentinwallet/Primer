//
//  CardPaymentViewModel.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import Foundation

protocol CardPaymentViewModelDelegate: AnyObject {
    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFinishPaymentWithToken token: String)
    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFailPaymentWithError error: PrimerAPIError)
}

final class CardPaymentViewModel {
    private let clientTokenService: ClientTokenServiceProtocol
    private let paymentInstrumentService: PaymentInstrumentServiceProtocol
    private let jwtDecoderService: JWTDecoderServiceProtocol

    private(set) var configuration: CheckoutBuilderConfiguration

    weak var delegate: CardPaymentViewModelDelegate?

    init(configuration: CheckoutBuilderConfiguration,
         clientTokenService: ClientTokenServiceProtocol = ClientTokenService(),
         paymentInstrumentService: PaymentInstrumentServiceProtocol = PaymentInstrumentService(),
         jwtDecoderService: JWTDecoderServiceProtocol = JWTDecoderService()) {
        self.configuration = configuration
        self.clientTokenService = clientTokenService
        self.paymentInstrumentService = paymentInstrumentService
        self.jwtDecoderService = jwtDecoderService
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
        guard let accessToken = self.jwtDecoderService.getAccessToken(from: clientToken.clientToken) else {
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
}
