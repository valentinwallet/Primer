//
//  CGFloat+Extension.swift
//  Primer
//
//  Created by Valentin Wallet on 6/3/22.
//

import UIKit

public struct Primer {
    public init() {}
    
    public static func build() -> UIViewController {
        return PrimerCheckoutViewController()
    }
}
