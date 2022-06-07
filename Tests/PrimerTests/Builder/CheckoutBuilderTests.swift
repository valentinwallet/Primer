//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import XCTest
@testable import Primer

final class CheckoutBuilderTests: XCTestCase {
    func test_build_should_create_checkout_coordinator() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let createCheckoutBuilderCoordinatorExpectation = self.expectation(description: "should call createCheckoutBuilderCoordinator() method")

        factoryMock.createCheckoutBuilderCoordinatorExpectation = createCheckoutBuilderCoordinatorExpectation

        // WHEN
        let checkoutCoordinator = builder.build()

        // THEN
        self.wait(for: [createCheckoutBuilderCoordinatorExpectation], timeout: 0.1)
        XCTAssertTrue(checkoutCoordinator is CheckoutCoordinator)
    }

    func test_build_default() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)

        // WHEN
        _ = builder.build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonTitleColor, .systemBackground, "wrong payButtonTitleColor value")
        XCTAssertEqual(factoryMock.configuration?.payButtonCornerRadius, .smallCornerRadius, "wrong payButtonCornerRadius value")
        XCTAssertEqual(factoryMock.configuration?.payButtonBackgroundColor.cgColor, UIColor.systemBackgroundInverted.cgColor, "wrong payButtonBackgroundColor value")
        XCTAssertEqual(factoryMock.configuration?.payButtonTitle, "Pay", "wrong payButtonTitle value")
        XCTAssertEqual(factoryMock.configuration?.payButtonImage, nil, "wrong payButtonImage value")
    }

    func test_build_pay_button_corner_radius() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let cornerRadius: CGFloat = 28

        // WHEN
        _ = builder
            .payButtonCornerRadius(cornerRadius)
            .build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonCornerRadius, cornerRadius)
    }

    func test_build_pay_button_color() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let color: UIColor = .red

        // WHEN
        _ = builder
            .payButtonColor(color)
            .build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonBackgroundColor, color)
    }

    func test_build_pay_button_image() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let image: UIImage? = UIImage(systemName: "creditcard")

        // WHEN
        _ = builder
            .payButtonImage(image)
            .build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonImage, image)
    }

    func test_build_pay_button_title() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let title = "Pay with card"

        // WHEN
        _ = builder
            .payButtonTitle(title)
            .build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonTitle, title)
    }

    func test_build_pay_button_title_color() {
        // GIVEN
        let factoryMock = CheckoutCoordinatorFactoryMock()
        let builder = CheckoutBuilder(checkoutBuilderCoordinatorFactory: factoryMock)
        let color: UIColor = .red

        // WHEN
        _ = builder
            .payButtonTitleColor(color)
            .build()

        // THEN
        XCTAssertEqual(factoryMock.configuration?.payButtonTitleColor, color)
    }
}

private final class CheckoutCoordinatorFactoryMock: CheckoutCoordinatorFactoryProtocol {
    var createCheckoutBuilderCoordinatorExpectation: XCTestExpectation?
    var paymentMethods: [PaymentMethod]?
    var configuration: CheckoutBuilderConfiguration?

    func createCheckoutBuilderCoordinator(paymentMethods: [PaymentMethod], configuration: CheckoutBuilderConfiguration) -> CheckoutCoordinatorProtocol {
        self.paymentMethods = paymentMethods
        self.configuration = configuration
        self.createCheckoutBuilderCoordinatorExpectation?.fulfill()
        return CheckoutCoordinator(paymentMethods: paymentMethods, configuration: configuration, checkoutViewControllerFactory: CheckoutViewControllerFactory())
    }
}
