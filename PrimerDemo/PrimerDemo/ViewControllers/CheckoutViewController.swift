//
//  CheckoutViewController.swift
//  PrimerDemo
//
//  Created by Valentin Wallet on 6/6/22.
//

import UIKit
import Combine
import Primer

final class CheckoutViewController: UIViewController {
    private var subscriptions: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    private func configureLayout() {
        let primerCheckoutViewController = PrimerCheckoutBuilder
            .payButtonTitle("Pay with card")
            .payButtonImage(UIImage(systemName: "creditcard"))
            .build()

        primerCheckoutViewController
            .tokenPublisher
            .sink { value in
                print(value)
            }
            .store(in: &subscriptions)

        self.addChilViewController(primerCheckoutViewController)
    }

    private func addChilViewController(_ viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = self.view.frame

        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
