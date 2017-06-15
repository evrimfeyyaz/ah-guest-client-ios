//
//  Created by Evrim Persembe on 6/3/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class ReservationAssociationByConfirmationCodeViewController: UIViewController {
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let labelStackView = UIStackView()
    private let inputContainerView = UIView()
    private let confirmationCodeTextField = ThemeViewFactory.textField()
    private let associateReservationByBookingConfirmationButton = ThemeViewFactory.filledButton()
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
        configureExplanationLabel()
        configureLabelStackView()
        configureConfirmationCodeTextField()
        configureAssociateReservationByConfirmationCodeButton()
        configureStackView()
        configureScrollView()
        configureActivityIndicator()
    }
    
    private func configureNavigationBar() {
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,
                                                  target: self,
                                                  action: #selector(cancelBarButtonItemTapped))
        let doneBarButtonItem = ThemeViewFactory.doneStyleBarButton(title: "Done",
                                                                    target: self,
                                                                    action: #selector(doneBarButtonItemTapped))
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Enter Your Confirmation Code"
        titleLabel.numberOfLines = 0
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "We were not able to find your reservation using the check-in date you entered. You can still check-in using your confirmation code.\n\nIf you do not know your confirmation code, please call reception and they will be happy to assist you."
        explanationLabel.numberOfLines = 0
    }
    
    private func configureLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(explanationLabel)
        
        labelStackView.axis = .vertical
    }
    
    private func configureConfirmationCodeTextField() {
        confirmationCodeTextField.attributedPlaceholder = NSAttributedString(string: "Confirmation Code",
                                                                       attributes: [
                                                                        NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                        NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        
        inputContainerView.addSubview(confirmationCodeTextField)
        confirmationCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmationCodeTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor),
            confirmationCodeTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor),
            confirmationCodeTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            confirmationCodeTextField.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            confirmationCodeTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }
    
    private func configureAssociateReservationByConfirmationCodeButton() {
        associateReservationByBookingConfirmationButton.setTitle("Done", for: .normal)
        associateReservationByBookingConfirmationButton.addTarget(self, action: #selector(addBookingConfirmationButtonTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, inputContainerView, associateReservationByBookingConfirmationButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
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
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
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
    
    @objc private func doneBarButtonItemTapped() {
        associateReservationByConfirmationCode()
    }
    
    @objc private func addBookingConfirmationButtonTapped() {
        associateReservationByConfirmationCode()
    }
    
    // MARK: - Private instance methods
    private func associateReservationByConfirmationCode() {
        guard let confirmationCode = confirmationCodeTextField.text else {
            let alertController = UIAlertController(title: "Confirmation Code", message: "Please enter your confirmation code.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        activityIndicatorView.startAnimating()
        
        APIManager.shared.createReservationAssociation(byConfirmationCode: confirmationCode) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success:
                self.dismiss(animated: true, completion: self.successCallback)
            case .failure(let error):
                switch error {
                case APIManagerError.apiProvidedError(let messages):
                    let alertController = UIAlertController(title: "Reservation Error", message: messages.first, preferredStyle: .alert)
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
