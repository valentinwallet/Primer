//
//  SceneDelegate.swift
//  PrimerDemo
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit
import Primer
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var subscriptions: Set<AnyCancellable> = .init()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let primerCheckoutViewController = PrimerCheckoutBuilder
            .payButtonImage(UIImage(systemName: "creditcard"))
            .payButtonTitle("Pay with card")
            .build()

        primerCheckoutViewController.completion = { result in
            switch result {
            case .success(let token):
                print("token")
            case .failure(let error):
                print("error")
            }
        }

//        primerCheckoutViewController
//            .publisher
//            .sink { value in
//                print(value)
//            }
//            .store(in: &subscriptions)

        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = primerCheckoutViewController
        self.window?.makeKeyAndVisible()
    }
}

