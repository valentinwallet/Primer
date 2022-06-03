//
//  PrimerCheckoutViewController.swift
//  Primer
//
//  Created by Valentin Wallet on 6/3/22.
//

public final class PrimerCheckoutViewController: UIViewController {
    private let paymentMethodStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            CardPaymentView()
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    private func configureLayout() {
        self.view.backgroundColor = .white
        
        self.configurePaymentMethodStackView()
    }

    private func configurePaymentMethodStackView() {
        self.view.addSubview(self.paymentMethodStackView)

        NSLayoutConstraint.activate([
            self.paymentMethodStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            self.paymentMethodStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .largeSpace),
            self.paymentMethodStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.largeSpace)
        ])
    }
}
