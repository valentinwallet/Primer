//
//  CardPaymentTextFieldView.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

protocol CardPaymentTextFieldViewDelegate: AnyObject {
    func cardPaymentTextFieldViewDidEndEditing(_ view: CardPaymentTextFieldView)
}

final class CardPaymentTextFieldView: CardPaymentBaseTextFieldView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.title
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var textField: UITextField = {
        let textField = PrimerTextField()
        textField.backgroundColor = .systemGray6
        textField.delegate = self
        textField.keyboardType = self.viewModel.keyboardType
        textField.layer.cornerRadius = .smallCornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private(set) var viewModel: CardPaymentTextFieldViewModel

    weak var delegate: CardPaymentTextFieldViewDelegate?

    init(viewModel: CardPaymentTextFieldViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.configureTitleLabel()
        self.configureTextField()
    }

    private func configureTitleLabel() {
        self.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    private func configureTextField() {
        self.addSubview(self.textField)

        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: .smallSpace),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension CardPaymentTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.viewModel.shouldChangeCharacters(textField: textField, range: range, replacementString: string)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.layer.borderWidth = 1
        self.textField.layer.borderColor = UIColor.black.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.textField.layer.borderWidth = 0
        self.delegate?.cardPaymentTextFieldViewDidEndEditing(self)
    }
}
