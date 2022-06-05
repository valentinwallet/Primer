//
//  CardPaymentView.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

protocol CardPaymentViewDelegate: AnyObject {
    func cardPaymentView(_ view: CardPaymentView, didPressPayButton button: UIButton)
}

final class CardPaymentView: UIView {
    private lazy var cardNumberView: CardPaymentBaseTextFieldView = {
        let view = CardPaymentTextFieldView(viewModel: CardNumberTextFieldViewModel())
        view.delegate = self
        return view
    }()

    private lazy var expiryDateView: CardPaymentBaseTextFieldView = {
        let view = CardPaymentTextFieldView(viewModel: ExpiryDateTextFieldViewModel())
        view.delegate = self
        return view
    }()

    private lazy var ccvView: CardPaymentBaseTextFieldView = {
        let view = CardPaymentTextFieldView(viewModel: CCVTextFieldViewModel())
        view.delegate = self
        return view
    }()

    private lazy var cardHolderView: CardPaymentBaseTextFieldView = {
        let view = CardPaymentTextFieldView(viewModel: CardHolderNameTextFieldViewModel())
        view.delegate = self
        return view
    }()

    private lazy var payButton: UIButton = {
        // TODO: pay title from viewModel
        let configuration = self.viewModel.configuration
        let button = PrimerButton(buttonTitle: configuration.payButtonTitle)
        button.setImage(configuration.payButtonImage, for: .normal)
        button.setTitleColor(configuration.payButtonTitleColor, for: .normal)
        button.layer.cornerRadius = configuration.payButtonCornerRadius
        button.backgroundColor = configuration.payButtonBackgroundColor
//        button.tintColor = configuration.payButtonTitleColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapOnPayButton(sender:)), for: .touchDown)
        return button
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.cardNumberView,
            self.horizontalStackView,
            self.cardHolderView,
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
            self.ccvView
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

// MARK: - Actions

extension CardPaymentView {
    @objc
    private func didTapOnPayButton(sender: UIButton) {
        self.delegate?.cardPaymentView(self, didPressPayButton: sender)
    }
}


extension CardPaymentView: CardPaymentTextFieldViewDelegate {
    func cardPaymentTextFieldViewDidEndEditing(_ view: CardPaymentTextFieldView) {
        if self.cardNumberView.validate(),
           self.expiryDateView.validate(),
           self.ccvView.validate(),
           self.cardHolderView.validate() {
            self.payButton.isEnabled = true
        } else {
            self.payButton.isEnabled = false
        }
    }
}
