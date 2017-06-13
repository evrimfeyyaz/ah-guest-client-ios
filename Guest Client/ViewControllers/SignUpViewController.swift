//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIScrollViewDelegate {
    private let scrollView = UIScrollView()
    private let titleLabel = StyledLabel(withStyle: .title1)
    private let inputContainerView = UIView()
    private let firstNameTextField = ThemeViewFactory.textField()
    private let lastNameTextField = ThemeViewFactory.textField()
    private let emailTextField = ThemeViewFactory.textField()
    private let passwordTextField = ThemeViewFactory.textField()
    private let passwordConfirmationTextField = ThemeViewFactory.textField()
    private let signUpButton = ThemeViewFactory.filledButton()
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var successCallback: (() -> Void)?
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureTitleLabel()
        configureFirstNameTextField()
        configureLastNameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configurePasswordConfirmationTextField()
        configureSignUpButton()
        configureStackView()
        configureScrollView()
        configureActivityIndicator()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Sign Up"
    }
    
    private func configureFirstNameTextField() {
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name (as it appears on your passport)",
                                                                  attributes: [
                                                                    NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                    NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        firstNameTextField.autocapitalizationType = .none
        firstNameTextField.autocorrectionType = .no
        
        inputContainerView.addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor),
            firstNameTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor),
            firstNameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }
    
    private func configureLastNameTextField() {
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name (as it appears on your passport)",
                                                                      attributes: [
                                                                        NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                        NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        lastNameTextField.autocapitalizationType = .none
        lastNameTextField.autocorrectionType = .no
        
        inputContainerView.addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            lastNameTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
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
            emailTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
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
            passwordTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }
    
    private func configurePasswordConfirmationTextField() {
        passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Password Confirmation",
                                                                     attributes: [
                                                                        NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                        NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        passwordConfirmationTextField.isSecureTextEntry = true
        passwordConfirmationTextField.autocapitalizationType = .none
        passwordConfirmationTextField.autocorrectionType = .no
        
        inputContainerView.addSubview(passwordConfirmationTextField)
        passwordConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordConfirmationTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            passwordConfirmationTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            passwordConfirmationTextField.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }
    
    private func configureSignUpButton() {
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpbuttonTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, inputContainerView, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }
    
    private func configureScrollView() {
        scrollView.keyboardDismissMode = .interactive
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    // MARK: - Actions
    @objc private func signUpbuttonTapped() {
        signUp()
    }
    
    // Adapted from: https://www.hackingwithswift.com/example-code/uikit/how-to-adjust-a-uiscrollview-to-fit-the-keyboard
    @objc private func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    // MARK: - Private instance methods
    private func signUp() {
        activityIndicatorView.startAnimating()
        
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
            let password = passwordTextField.text, let passwordConfirmation = passwordConfirmationTextField.text {
            APIManager.shared.createUser(email: email, firstName: firstName, lastName: lastName,
                                         password: password, passwordConfirmation: passwordConfirmation) { result in
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
                    switch error {
                    case APIManagerError.apiProvidedError(let messages):
                        let alertController = UIAlertController(title: "Sign Up Error", message: messages.joined(separator: "\n"), preferredStyle: .alert)
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
