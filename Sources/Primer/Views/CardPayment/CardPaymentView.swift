//
//  CardPaymentView.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class CardPaymentView: UIView {
    private let cardNumberView: CardPaymentTextFieldView = CardPaymentTextFieldView(viewModel: CardNumberTextFieldViewModel())
    private let expiryDateView: CardPaymentTextFieldView = CardPaymentTextFieldView(viewModel: ExpiryDateTextFieldViewModel())
    private let ccvView: CardPaymentTextFieldView = CardPaymentTextFieldView(viewModel: CCVTextFieldViewModel())
    private let cardHolderView: CardPaymentTextFieldView = CardPaymentTextFieldView(viewModel: CardHolderTextFieldViewModel())

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.cardNumberView,
            self.horizontalStackView,
            self.cardHolderView,
        ])
        stackView.axis = .vertical
        stackView.spacing = .largeSpace
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.expiryDateView,
            self.ccvView
        ])
        stackView.axis = .horizontal
        stackView.spacing = .extraLargeSpace
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.addSubview(self.verticalStackView)

        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
