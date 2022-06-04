//
//  CGFloat+Extension.swift
//  Primer
//
//  Created by Valentin Wallet on 6/3/22.
//

import UIKit

public struct Primer {
    public init() {}

    /// Build a UIViewController used for checkout with multiple payments methods
    /// - Returns: UIViewController
    public static func build() -> UIViewController {
        return PrimerCheckoutViewController()
    }
}
