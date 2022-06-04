//
//  PrimerCheckoutViewController.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class PrimerCheckoutViewController: UIViewController {
    private let paymentMethodStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            CardPaymentView()
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    private func configureLayout() {
        self.view.backgroundColor = .systemBackground

        self.configurePaymentMethodStackView()
    }

    private func configurePaymentMethodStackView() {
        self.view.addSubview(self.paymentMethodStackView)

        NSLayoutConstraint.activate([
            self.paymentMethodStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .largeSpace),
            self.paymentMethodStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .largeSpace),
            self.paymentMethodStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.largeSpace)
        ])
    }
}
