//
//  CardPaymentView.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

protocol CardPaymentViewDelegate: AnyObject {
    func cardPaymentView(_ cardPaymentView: CardPaymentView, didAuthorizePaymentMethodForToken token: String)
    func cardPaymentView(_ cardPaymentView: CardPaymentView, didFailAuthorizePaymentMethodWithError error: PrimerAPIError)
}

final class CardPaymentView: UIView {
    private var cardNumberView: CardPaymentBaseTextFieldView = CardPaymentTextFieldView(viewModel: CardNumberTextFieldViewModel())
    private var expiryDateView: CardPaymentBaseTextFieldView = CardPaymentTextFieldView(viewModel: ExpiryDateTextFieldViewModel())
    private var cardHoldernameView: CardPaymentBaseTextFieldView = CardPaymentTextFieldView(viewModel: CardHolderNameTextFieldViewModel())
    private var cvvView: CardPaymentBaseTextFieldView = CardPaymentTextFieldView(viewModel: CCVTextFieldViewModel())

    private lazy var payButton: PrimerButton = {
        let button = PrimerButton()
        button.configure(with: self.viewModel.configuration)
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapOnPayButton(sender:)), for: .touchDown)
        return button
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.cardNumberView,
            self.horizontalStackView,
            self.cardHoldernameView,
            self.payButton
        ])
        stackView.axis = .vertical
        stackView.spacing = .largeSpace
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.expiryDateView,
            self.cvvView
        ])
        stackView.axis = .horizontal
        stackView.spacing = .extraLargeSpace
        stackView.distribution = .fillEqually
        return stackView
    }()

    weak var delegate: CardPaymentViewDelegate?

    private let viewModel: CardPaymentViewModel

    init(viewModel: CardPaymentViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.configureVerticalStackView()
        self.configureCardPaymentTextFieldViews()
    }

    private func configureVerticalStackView() {
        self.addSubview(self.verticalStackView)

        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func configureCardPaymentTextFieldViews() {
        self.cvvView.delegate = self
        self.cardNumberView.delegate = self
        self.expiryDateView.delegate = self
        self.cardHoldernameView.delegate = self
    }
}

// MARK: - Actions
extension CardPaymentView {
    @objc
    private func didTapOnPayButton(sender: UIButton) {
        let cardDetails = CardDetails(number: self.cardNumberView.textFieldText(),
                                      cvv: self.cvvView.textFieldText(),
                                      expirationMonth: self.expiryDateView.expirationMonth(),
                                      expirationYear: self.expiryDateView.expirationYear(),
                                      cardholderName: self.cardHoldernameView.textFieldText())
        self.payButton.showLoader()
        self.viewModel.initiatePayment(for: cardDetails)
    }

    private func hidePayButtonLoader() {
        DispatchQueue.main.async {
            self.payButton.hideLoader()
        }
    }
}

// MARK: - CardPaymentViewModelDelegate
extension CardPaymentView: CardPaymentViewModelDelegate {
    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFinishPaymentWithToken token: String) {
        self.hidePayButtonLoader()
        self.delegate?.cardPaymentView(self, didAuthorizePaymentMethodForToken: token)
    }

    func cardPaymentViewModel(_ viewModel: CardPaymentViewModel, didFailPaymentWithError error: PrimerAPIError) {
        self.hidePayButtonLoader()
        self.delegate?.cardPaymentView(self, didFailAuthorizePaymentMethodWithError: error)
    }
}

// MARK: - CardPaymentTextFieldViewDelegate
extension CardPaymentView: CardPaymentTextFieldViewDelegate {
    func cardPaymentTextFieldViewDidChange(_ view: CardPaymentTextFieldView) {
        if self.cardNumberView.validate(),
           self.expiryDateView.validate(),
           self.cvvView.validate(),
           self.cardHoldernameView.validate() {
            self.payButton.isEnabled = true
        } else {
            self.payButton.isEnabled = false
        }
    }
}
