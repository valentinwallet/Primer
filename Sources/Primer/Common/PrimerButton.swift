//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit

final class PrimerButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.7 : 1
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1 : 0.3
        }
    }

    init(buttonTitle: String) {
        super.init(frame: .zero)
        self.setTitle(buttonTitle, for: .normal)
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.backgroundColor = .systemBackgroundInverted
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.layer.cornerRadius = .smallCornerRadius
        self.setTitleColor(.systemBackground, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
