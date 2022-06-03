//
//  CardPaymentView.swift
//  Primer
//
//  Created by Valentin Wallet on 6/3/22.
//

final class CardPaymentView: UIView {
    private let cardNumberView: CardPaymentTextFieldView = CardPaymentTextFieldView(title: "Card Number")
    private let expiryDateView: CardPaymentTextFieldView = CardPaymentTextFieldView(title: "Expiry Date")
    private let ccvView: CardPaymentTextFieldView = CardPaymentTextFieldView(title: "CCV")
    private let cardHolderView: CardPaymentTextFieldView = CardPaymentTextFieldView(title: "Cardholder Name")

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
