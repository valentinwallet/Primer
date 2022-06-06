//
//  SceneDelegate.swift
//  PrimerDemo
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit
import Primer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let primerCheckoutViewController = PrimerCheckoutBuilder
            .payButtonImage(UIImage(systemName: "creditcard"))
            .payButtonTitle("Pay with card")
            .build()

        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = primerCheckoutViewController
        self.window?.makeKeyAndVisible()
    }
}

