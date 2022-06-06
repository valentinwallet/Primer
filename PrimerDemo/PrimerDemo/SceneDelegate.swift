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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)

        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

