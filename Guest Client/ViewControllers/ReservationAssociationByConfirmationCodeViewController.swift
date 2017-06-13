//
//  Created by Evrim Persembe on 6/3/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class ReservationAssociationByConfirmationCodeViewController: UIViewController {
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
        explanationLabel.text = "We were not able to find your reservation using the check-in date you entered. You can still check-in using your confirmation code. Please call reception if you do not know your confirmation code and they will be happy to help you."
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
        confirmationCodeTextField.keyboardType = .numberPad
        
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
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView, inputContainerView, associateReservationByBookingConfirmationButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -navigationBarHeight)
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
