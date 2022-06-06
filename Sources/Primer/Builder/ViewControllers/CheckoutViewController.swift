//
//  PrimerCheckoutViewController.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit
import Combine

final class CheckoutViewController: CheckoutBaseViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let paymentMethodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .largeSpace
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: .extraLargeSpace, left: .largeSpace, bottom: .extraLargeSpace, right: .largeSpace)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let viewModel: CheckoutViewModel

    var publisher: AnyPublisher<TokenValue, Never> { self.subject.eraseToAnyPublisher() }
    private let subject = PassthroughSubject<TokenValue, Never>()

    var completion: ((Result<String, PrimerAPIError>) -> Void)?

    weak var delegate: CheckoutViewControllerDelegate?

    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    private func configureLayout() {
        self.view.backgroundColor = .systemBackground

        self.configureScrollView()
        self.configurePaymentMethodStackView()
    }

    private func configureScrollView() {
        self.view.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func configurePaymentMethodStackView() {
        self.scrollView.addSubview(self.paymentMethodStackView)

        for paymentMethodView in self.viewModel.getPaymentMethodViews() {
            paymentMethodView.delegate = self
            self.paymentMethodStackView.addArrangedSubview(paymentMethodView)
        }

        NSLayoutConstraint.activate([
            self.paymentMethodStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: .largeSpace),
            self.paymentMethodStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.paymentMethodStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.paymentMethodStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.paymentMethodStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }
}

// MARK: - CheckoutViewControllerProtocol

extension CheckoutViewController: PaymentViewDelegate {
    func paymentView(_ paymentView: PaymentView, didAuthorizePaymentForToken token: String) {
        self.delegate?.checkoutViewController(self, didAuthorizePaymentForToken: token)
        self.subject.send(.success(token: token))
        self.completion?(.success(token))
    }

    func paymentView(_ paymentView: PaymentView, didFailPaymentWithError error: PrimerAPIError) {
        self.delegate?.checkoutViewController(self, didFailPaymentWithError: error)
        self.subject.send(.failure(error: error))
        self.completion?(.failure(error))
    }
}
