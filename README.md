Primer is a SDK that will allow you to show a nice checkout view controller and get authorization tokens from the payment methods present.

## Features

- [x] Showing a nice checkout view controller thanks to a builder easy to use
- [x] Swift Support Back to iOS 13
- [x] Get the authorization token from multiple way : Delegate, Combine or Completion block
- [x] Customization of the checkout view controller pay button
- [x] Dark and light mode support
- [x] Stable : test coverage

## Requirements

| Platform | Minimum Swift Version | Availability |
| --- | --- | --- |
| iOS 13.0+ | 5.0 | Swift Package Manager, Cocoapods | Fully Tested |

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Primer into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Primer', :git => 'https://github.com/valentinwallet/Primer.git'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

In Xcode go to :
- File > Swift Packages > Add Package Dependency
- Search and add for https://github.com/valentinwallet/Primer.git

## Screenshots

| LightMode | Dark Mode |
| --- | --- |
| ![DarkMode](https://raw.githubusercontent.com/valentinwallet/Primer/main/Ressources/screenshotDark.png) | ![LightMode](https://raw.githubusercontent.com/valentinwallet/Primer/main/Ressources/screenshotLight.png) |

## How to use it 

To use the Primer Checkout Coordinator you simply need to :

```swift
let _ = PrimerCheckoutBuilder
            .build()
            .start(from: presentingViewController)
```

That will build the `CheckoutCoordinator` and present it from the view you specified in `start(from:)` method.

### Customization

For more customization, about the pay button or payment methods, you can use the builder this way :

```swift
PrimerCheckoutBuilder
            .payButtonColor(.systemTeal) // Change pay button background color
            .payButtonTitleColor(.systemRed) // Change pay button title color
            .payButtonTitle("Pay with card") // Change pay button title
            .payButtonCornerRadius(16) // Change pay button corner radius
            .payButtonImage(UIImage(systemName: "creditcard")) // change pay button image
            .addPaymentMethod(.applePay(merchantId: "merchantId")) // add new payment method
            .build()
```

This customization leads us to this result :
![Custom](https://raw.githubusercontent.com/valentinwallet/Primer/main/Ressources/custom.png)

So choose your colors wisely 🧙‍♂️

### Combine
