//
//  ApplePayView.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit
import PassKit

protocol ApplePayViewDelegate: AnyObject {
    func applePayView(_ view: ApplePayView, DidPressApplePayButtonForPaymentRequest paymentRequest: PKPaymentRequest)
}

final class ApplePayView: UIView {
    private lazy var payButton: PrimerButton = {
        let button = PrimerButton()
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackgroundInverted
        button.setTitle("Pay with apple pay", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.setImage(UIImage(systemName: "applelogo"), for: .normal)
        button.addTarget(self, action: #selector(didTapOnPayButton(sender:)), for: .touchDown)
        return button
    }()

    private let viewModel: ApplePayViewModel

    weak var delegate: ApplePayViewDelegate?

    init(viewModel: ApplePayViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.configurePayButton()
    }

    private func configurePayButton() {
        self.addSubview(self.payButton)

        NSLayoutConstraint.activate([
            self.payButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.payButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.payButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.payButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension ApplePayView {
    @objc
    private func didTapOnPayButton(sender: UIButton) {
        self.delegate?.applePayView(self, DidPressApplePayButtonForPaymentRequest: self.viewModel.getPaymentRequest())
    }
}
