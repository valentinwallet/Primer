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
        print(cardDetails)
        self.clientTokenService.getClientToken { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let clientToken):
                self.paymentInstrumentService
                    .getPaymentToken(for: clientToken.clientToken, cardDetails: cardDetails) { [weak self] in
                        self?.handlePaymentInstrumentServiceResult($0)
                    }
            case .failure(let error):
                self.delegate?.cardPaymentViewModel(self, didFailPaymentWithError: error)
            }
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
