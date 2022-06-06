//
//  PrimerCheckoutViewController.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CheckoutViewController: UIViewController {
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

extension CheckoutViewController: PaymentViewDelegate {
    func paymentView(_ paymentView: PaymentView, didFailPaymentWithError error: PrimerAPIError) {
        print("error: \(error)")
    }

    func paymentView(_ paymentView: PaymentView, didAuthorizePaymentForToken token: String) {
        print("token: \(token)")
    }
}
