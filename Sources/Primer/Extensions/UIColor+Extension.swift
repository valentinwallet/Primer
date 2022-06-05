//
//  UIColor+Extension.swift
//  
//
//  Created by Valentin Wallet on 6/5/22.
//

import UIKit

extension UIColor {
    static var systemBackgroundInverted: UIColor {
        return UIColor { $0.userInterfaceStyle == .dark ? UIColor.white : UIColor.black }
    }
}
