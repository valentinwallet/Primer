//
//  UIApplication+Extension.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import UIKit

extension UIApplication {
    static func getTopViewController() -> UIViewController? {
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else { return nil }

        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }

        return topController
    }
}
