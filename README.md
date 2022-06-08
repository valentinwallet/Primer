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
let coordinator = PrimerCheckoutBuilder
            .build()

coordinator.start(from: presentingViewController)
```

That will build the `CheckoutCoordinator` and present it from the view you specified in `start(from:)` method.

### Combine

You have the option to get the token back using the power of Combine.

```swift
var subscriptions: Set<AnyCancellable> = .init()

let coordinator = PrimerCheckoutBuilder
            .build
            
coordinator
    .tokenPublisher
    .sink { tokenValue in
        switch tokenValue {
        case .failure(let error):
            // use error
        case .success(let token):
            // use token
        }
    }
    .store(in: &self.subscriptions)

coordinator.start(from: presentingViewController)
```

### Delegate

You have the option to get the token back using the power of Delegates.

```swift
let coordinator = PrimerCheckoutBuilder
            .build
            
coordinator.delegate = self

coordinator.start(from: presentingViewController)
```

### Completion

You have the option to get the token back using the power of completion block.

```swift
let coordinator = PrimerCheckoutBuilder
            .build
            
coordinator.onTokenSuccess { token
    // use token
}
coordinator.onTokenFailure { error
    // use error
}

coordinator.start(from: presentingViewController)
```


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

## Payment Methods

✅  Payment with card 
⚠️ Payment with Apple Pay [WIP]
*Apple will trigger always the same amount and by adding this payment I just wanted to show how "easy" it was to add a new payment method in the current architecture*

## Try it with the App Demo

- Open `PrimerDemo/PrimerDemo.xcodeproj` in Xcode
- In Xcode, go to `File -> Packages -> Resolve package versions`
- Then run the project and you can use `HomeViewController` as a sandbox


