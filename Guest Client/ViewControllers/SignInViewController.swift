//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class SignInViewController: UIViewController {
    
    // MARK: - Private properties
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let titleLabel = StyledLabel(withStyle: .title1)
    private let inputContainerView = UIView()
    private let emailTextField = ThemeViewFactory.textField()
    private let passwordTextField = ThemeViewFactory.textField()
    private let signInButton = ThemeViewFactory.filledButton()
    private let signUpButton = ThemeViewFactory.hollowButton()
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var successCallback: (() -> Void)?

    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage

        configureNavigationBar()
        configureTitleLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureSignInButton()
        configureSignUpButton()
        configureStackView()
        configureScrollView()
        configureActivityIndicator()
    }

    private func configureNavigationBar() {
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,
                                                  target: self,
                                                  action: #selector(cancelBarButtonItemTapped))
        let signUpBarButtonItem = ThemeViewFactory.doneStyleBarButton(title: "Sign Up",
                                                                      target: self,
                                                                      action: #selector(signUpBarButtonItemTapped))

        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = signUpBarButtonItem

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: nil, action: nil)
    }

    private func configureTitleLabel() {
        titleLabel.text = "Sign In"
    }

    private func configureEmailTextField() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Mail Address",
                                                                  attributes: [
                                                                    NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                    NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no

        inputContainerView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }

    private func configurePasswordTextField() {
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [
                                                                        NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                        NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no

        inputContainerView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }

    private func configureSignInButton() {
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }

    private func configureSignUpButton() {
        signUpButton.setTitle("Sign Up For An Account", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    private func configureStackView() {
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0

        let stackView = UIStackView(arrangedSubviews: [titleLabel, inputContainerView, signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 15

        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -navigationBarHeight),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }
    
    private func configureScrollView() {
        scrollView.keyboardDismissMode = .onDrag
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }

    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center

        view.addSubview(activityIndicatorView)
    }

    // MARK: - Actions

    @objc private func cancelBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func signInButtonTapped() {
        signIn()
    }
    
    @objc private func signUpBarButtonItemTapped() {
        goToSignUp()
    }
    
    @objc private func signUpButtonTapped() {
        goToSignUp()
    }
    
    // MARK: - Private instance methods
    
    private func goToSignUp() {
        let signUpVC = SignUpViewController()
        signUpVC.successCallback = successCallback
        
        show(signUpVC, sender: self)
    }
    
    private func signIn() {
        activityIndicatorView.startAnimating()
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            APIManager.shared.createAuthentication(email: email, password: password) { result in
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
                
                switch result {
                case .success:
                    guard let currentUser = APIManager.shared.currentUser else { return }
                    
                    if currentUser.currentOrUpcomingReservation != nil {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: self.successCallback)
                        }
                    } else {
                        DispatchQueue.main.async {
                            let reservationAssociationByCheckInDateVC = ReservationAssociationByCheckInDateViewController()
                            reservationAssociationByCheckInDateVC.successCallback = self.successCallback
                            self.show(reservationAssociationByCheckInDateVC, sender: nil)
                        }
                    }
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet {
                        let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
                            self?.signIn()
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true)
                        
                        break
                    }
                
                    switch error {
                    case APIManagerError.userAuthentication(let reason):
                        let alertController = UIAlertController(title: "Error Signing In", message: reason, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true)
                    default:
                        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true)
                    }
                }
            }
        }
    }
}
