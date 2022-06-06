//
//  HomeViewController.swift
//  PrimerDemo
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var goToCheckoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Go to checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.didTapGoToCheckoutButton(sender:)), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureLayout()
    }

    private func configureLayout() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.goToCheckoutButton)

        NSLayoutConstraint.activate([
            self.goToCheckoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.goToCheckoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.goToCheckoutButton.heightAnchor.constraint(equalToConstant: 40),
            self.goToCheckoutButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension HomeViewController {
    @objc
    private func didTapGoToCheckoutButton(sender: UIButton) {
        let checkoutViewController = CheckoutViewController()
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
}
