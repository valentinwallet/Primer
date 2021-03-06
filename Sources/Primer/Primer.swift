//
//  Primer.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

/// Enum regrouping every services of the `Primer` package.
public enum Primer {
    /// Create a checkout builder in order to build a `CheckoutViewController`.
    /// - Returns: CheckoutBuilder
    public static func checkoutBuilder() -> CheckoutBuilder {
        return CheckoutBuilder()
    }
}

/// Reference to `Primer.checkoutBuilder` for quick bootstraping and examples.
public let PrimerCheckoutBuilder = Primer.checkoutBuilder()
