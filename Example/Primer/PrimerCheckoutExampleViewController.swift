//
//  PrimerCheckoutExampleViewController.swift
//  Primer
//
//  Created by Valentin Wallet on 06/03/2022.
//  Copyright (c) 2022 Valentin Wallet. All rights reserved.
//

import UIKit
import Primer

final class PrimerCheckoutExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        self.view.isUserInteractionEnabled = true

        let checkoutViewController = Primer.build()
        self.present(checkoutViewController, animated: true, completion: nil)
    }
}

