//
//  File.swift
//  
//
//  Created by Valentin Wallet on 6/6/22.
//

import XCTest
@testable import Primer

final class CheckoutBuilderTests: XCTestCase {
    func test_build_should_create_checkout_view_controller() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let createCheckoutViewControllerExpectation = self.expectation(description: "should call createCheckoutViewController()")

        viewControllerFactory.createCheckoutViewControllerExpectation = createCheckoutViewControllerExpectation

        // WHEN
        _ = builder.build()

        // THEN
        self.wait(for: [createCheckoutViewControllerExpectation], timeout: 0.1)
    }

    func test_build_view_controller_type() {
        // GIVEN
        let builder = CheckoutBuilder()

        // WHEN...THEN
        XCTAssertTrue(builder.build() is CheckoutViewController)
    }

    func test_build_default() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)

        // WHEN
        _ = builder.build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonTitleColor, .systemBackground, "wrong payButtonTitleColor value")
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonCornerRadius, .smallCornerRadius, "wrong payButtonCornerRadius value")
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonBackgroundColor.cgColor, UIColor.systemBackgroundInverted.cgColor, "wrong payButtonBackgroundColor value")
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonTitle, "Pay", "wrong payButtonTitle value")
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonImage, nil, "wrong payButtonImage value")
    }

    func test_build_pay_button_corner_radius() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let cornerRadius: CGFloat = 28

        // WHEN
        _ = builder
            .payButtonCornerRadius(cornerRadius)
            .build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonCornerRadius, cornerRadius)
    }

    func test_build_pay_button_color() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let color: UIColor = .red

        // WHEN
        _ = builder
            .payButtonColor(color)
            .build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonBackgroundColor, color)
    }

    func test_build_pay_button_image() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let image: UIImage? = UIImage(systemName: "creditcard")

        // WHEN
        _ = builder
            .payButtonImage(image)
            .build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonImage, image)
    }

    func test_build_pay_button_title() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let title = "Pay with card"

        // WHEN
        _ = builder
            .payButtonTitle(title)
            .build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonTitle, title)
    }

    func test_build_pay_button_title_color() {
        // GIVEN
        let viewControllerFactory = ViewControllerFactoryMock()
        let builder = CheckoutBuilder(viewControllerFactory: viewControllerFactory)
        let color: UIColor = .red

        // WHEN
        _ = builder
            .payButtonTitleColor(color)
            .build()

        // THEN
        XCTAssertEqual(viewControllerFactory.configuration?.payButtonTitleColor, color)
    }
}

private final class ViewControllerFactoryMock: ViewControllerFactoryProtocol {
    var createCheckoutViewControllerExpectation: XCTestExpectation?
    var configuration: CheckoutBuilderConfiguration?
    var paymentMethods: [PaymentMethod]?

    func createCheckoutViewController(configuration: CheckoutBuilderConfiguration, paymentMethods: [PaymentMethod]) -> UIViewController {
        self.configuration = configuration
        self.paymentMethods = paymentMethods
        self.createCheckoutViewControllerExpectation?.fulfill()
        return UIViewController()
    }
}
