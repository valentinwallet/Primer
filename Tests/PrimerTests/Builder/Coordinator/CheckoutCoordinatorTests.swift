//
//  CheckoutCoordinatorTests.swift
//  
//
//  Created by Valentin Wallet on 6/7/22.
//

import XCTest
import Combine
@testable import Primer

final class CheckoutCoordinatorTests: XCTestCase {
    private var subscriptions: Set<AnyCancellable> = .init()

    func test_start_should_create_checkout_view_controller_and_present_it() {
        // GIVEN
        let viewControllerMock = UIViewControllerMock()
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let createCheckoutViewControllerExpectation = self.expectation(description: "should call createCheckoutViewControllerExpectation() method")
        let presentExpectation = self.expectation(description: "should call present() method")

        viewControllerMock.presentExpectation = presentExpectation
        checkoutViewControllerFactoryMock.createCheckoutViewControllerExpectation = createCheckoutViewControllerExpectation

        // WHEN
        coordinator.start(from: viewControllerMock)

        // THEN
        self.wait(for: [createCheckoutViewControllerExpectation, presentExpectation], timeout: 0.1, enforceOrder: true)
        let navigationControllerPresented = viewControllerMock.viewControllerToPresent as? UINavigationController
        XCTAssertNotNil(navigationControllerPresented?.viewControllers[0] as? CheckoutViewController)
    }

    func test_start_should_create_payment_method_section_views_card() {
        // GIVEN
        let viewControllerMock = UIViewControllerMock()
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)

        // WHEN
        coordinator.start(from: viewControllerMock)

        // THEN
        XCTAssertEqual(checkoutViewControllerFactoryMock.paymentMethodSectionViews?.count, 1)
        XCTAssertTrue(checkoutViewControllerFactoryMock.paymentMethodSectionViews?[0] is CardPaymentView)
    }

    func test_retrieve_token_from_delegate_success() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())
        let delegate = CheckoutCoordinatorDelegateMock()
        let didAuthorizePaymentMethodExpectation = self.expectation(description: "should call didAuthorizePaymentMethodExpectation() delegate method")

        coordinator.delegate = delegate
        delegate.didAuthorizePaymentMethodExpectation = didAuthorizePaymentMethodExpectation

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didAuthorizePaymentMethodForToken: "token")

        // THEN
        self.wait(for: [didAuthorizePaymentMethodExpectation], timeout: 0.1)
        XCTAssertEqual(delegate.token, "token")
    }

    func test_retrieve_token_from_delegate_failure() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())
        let delegate = CheckoutCoordinatorDelegateMock()
        let didFailAuthorizePaymentMethodExpectation = self.expectation(description: "should call didFailAuthorizePaymentMethodExpectation() delegate method")

        coordinator.delegate = delegate
        delegate.didFailAuthorizePaymentMethodExpectation = didFailAuthorizePaymentMethodExpectation

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didFailAuthorizePaymentMethodWithError: .decode)
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didAuthorizePaymentMethodForToken: "token")

        // THEN
        self.wait(for: [didFailAuthorizePaymentMethodExpectation], timeout: 0.1)
        XCTAssertEqual(delegate.error, .decode)
    }

    func test_retrieve_token_from_publisher_success() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didAuthorizePaymentMethodForToken: "token")

        // THEN
        coordinator.tokenPublisher.sink { tokenValue in

            switch tokenValue {
            case .success(let token):
                XCTAssertEqual(token, "token")
            case .failure(_):
                XCTFail("should not be a failure")
            }
        }.store(in: &self.subscriptions)
    }

    func test_retrieve_token_from_publisher_failure() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didFailAuthorizePaymentMethodWithError: .decode)

        // THEN
        coordinator.tokenPublisher.sink { tokenValue in
            switch tokenValue {
            case .success(_):
                XCTFail("should not be a success")
            case .failure(let error):
                XCTAssertEqual(error, .decode)
            }
        }.store(in: &self.subscriptions)
    }

    func test_retrieve_token_from_completion_success() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didAuthorizePaymentMethodForToken: "token")

        // THEN
        coordinator.onTokenSuccess = { token in
            XCTAssertEqual(token, "token")
        }
    }

    func test_retrieve_token_from_completion_failure() {
        // GIVEN
        let checkoutViewControllerFactoryMock = CheckoutViewControllerFactory()
        let coordinator = CheckoutCoordinator(paymentMethods: [.card],
                                              configuration: CheckoutBuilderConfiguration(),
                                              checkoutViewControllerFactory: checkoutViewControllerFactoryMock)
        let cardPaymentCoordinator = CardPaymentCoordinator(configuration: CheckoutBuilderConfiguration())

        // WHEN
        coordinator.paymentMethodCoordinator(cardPaymentCoordinator, didFailAuthorizePaymentMethodWithError: .decode)

        // THEN
        coordinator.onTokenFailure = { error in
            XCTAssertEqual(error, .decode)
        }
    }
}

private final class CheckoutCoordinatorDelegateMock: CheckoutCoordinatorDelegate {
    var didAuthorizePaymentMethodExpectation: XCTestExpectation?
    var didFailAuthorizePaymentMethodExpectation: XCTestExpectation?
    var token: String?
    var error: PrimerAPIError?

    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didAuthorizeMethodPaymentForToken token: String) {
        self.token = token
        self.didAuthorizePaymentMethodExpectation?.fulfill()
    }

    func checkoutBuilderCoordinator(_ coordinator: CheckoutCoordinatorProtocol, didFailAuthorizePaymentMethodWithError error: PrimerAPIError) {
        self.error = error
        self.didFailAuthorizePaymentMethodExpectation?.fulfill()
    }
}

private final class CheckoutViewControllerFactory: CheckoutViewControllerFactoryProtocol {
    var createCheckoutViewControllerExpectation: XCTestExpectation?
    var paymentMethodSectionViews: [UIView]?

    func createCheckoutViewController(paymentMethodSectionViews: [UIView]) -> CheckoutViewController {
        self.paymentMethodSectionViews = paymentMethodSectionViews
        self.createCheckoutViewControllerExpectation?.fulfill()
        return CheckoutViewController(viewModel: CheckoutViewModel(paymentMethodSectionViews: []))
    }
}

private final class UIViewControllerMock: UIViewController {
    var presentExpectation: XCTestExpectation?
    var viewControllerToPresent: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
        self.presentExpectation?.fulfill()
        super.present(viewControllerToPresent, animated: false, completion: nil)
    }
}
