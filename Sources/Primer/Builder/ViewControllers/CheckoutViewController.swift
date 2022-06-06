//
//  PrimerCheckoutViewController.swift
//  
//
//  Created by Valentin Wallet on 6/4/22.
//

import UIKit
import Combine

final class CheckoutViewController: CheckoutBaseViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let paymentMethodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .largeSpace
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: .largeSpace, left: .largeSpace, bottom: .largeSpace, right: .largeSpace)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Combine method
    var tokenPublisher: AnyPublisher<TokenValue, Never> { self.subject.eraseToAnyPublisher() }
    private let subject = PassthroughSubject<TokenValue, Never>()

    // MARK: - Completion method
    var onTokenSuccess: ((String) -> Void)?
    var onTokenFailure: ((PrimerAPIError) -> Void)?

    // MARK: - Delegate method
    weak var delegate: CheckoutViewControllerDelegate?

    private let viewModel: CheckoutViewModel

    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    private func configureLayout() {
        self.view.backgroundColor = .systemBackground

        self.configureScrollView()
        self.configurePaymentMethodStackView()
        self.listenKeyboardChanges()
        self.listenTapOnScreen()
    }

    private func configureScrollView() {
        self.view.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func configurePaymentMethodStackView() {
        self.scrollView.addSubview(self.paymentMethodStackView)

        for paymentMethodView in self.viewModel.getPaymentMethodViews() {
            paymentMethodView.delegate = self
            self.paymentMethodStackView.addArrangedSubview(paymentMethodView)
        }

        NSLayoutConstraint.activate([
            self.paymentMethodStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.paymentMethodStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.paymentMethodStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.paymentMethodStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.paymentMethodStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }

    private func listenKeyboardChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func listenTapOnScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - CheckoutViewControllerProtocol

extension CheckoutViewController: PaymentViewDelegate {
    func paymentView(_ paymentView: PaymentView, didAuthorizePaymentForToken token: String) {
        self.delegate?.checkoutViewController(self, didAuthorizePaymentForToken: token)
        self.subject.send(.success(token: token))
        self.onTokenSuccess?(token)
    }

    func paymentView(_ paymentView: PaymentView, didFailPaymentWithError error: PrimerAPIError) {
        self.delegate?.checkoutViewController(self, didFailPaymentWithError: error)
        self.subject.send(.failure(error: error))
        self.onTokenFailure?(error)
    }
}

// MARK: - Keyboard actions

extension CheckoutViewController {
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + .extraLargeSpace

        self.scrollView.contentInset = contentInset
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentInset = .zero
    }

    @objc
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
