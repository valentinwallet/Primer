//
//  PrimerButton.swift
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
        self.configureLayout()
        self.setTitle(buttonTitle, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .mediumSpace)
        self.tintColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
