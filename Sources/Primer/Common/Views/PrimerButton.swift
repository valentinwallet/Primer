//
//  PrimerButton.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class PrimerButton: UIButton {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .systemBackground
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override var isHighlighted: Bool {
        didSet { self.alpha = isHighlighted ? 0.7 : 1 }
    }

    override var isEnabled: Bool {
        didSet { self.alpha = isEnabled ? 1 : 0.3 }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.configureButtonLayout()
        self.configureActivityIndicatorLayout()
    }

    private func configureButtonLayout() {
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .mediumSpace)

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func configureActivityIndicatorLayout() {
        self.addSubview(self.activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    // MARK: - Public methods

    func configure(with configuration: CheckoutBuilderConfiguration) {
        self.setTitle(configuration.payButtonTitle, for: .normal)
        self.setImage(configuration.payButtonImage, for: .normal)
        self.setTitleColor(configuration.payButtonTitleColor, for: .normal)
        self.layer.cornerRadius = configuration.payButtonCornerRadius
        self.backgroundColor = configuration.payButtonBackgroundColor
        self.tintColor = configuration.payButtonTitleColor
    }

    func showLoader() {
        self.titleLabel?.layer.opacity = 0
        self.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        self.activityIndicatorView.startAnimating()
    }

    func hideLoader() {
        self.activityIndicatorView.stopAnimating()
        self.titleLabel?.layer.opacity = 1
        self.imageView?.layer.transform = CATransform3DIdentity
    }
}
