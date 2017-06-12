//
//  Created by Evrim Persembe on 6/3/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class ReservationAssociationByConfirmationCodeViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let labelStackView = UIStackView()
    private let inputContainerView = UIView()
    private let confirmationCodeTextField = ThemeViewFactory.textField()
    private let associateReservationByBookingConfirmationButton = ThemeViewFactory.filledButton()
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    
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
        explanationLabel.text = "We were not able to find your reservation by the check-in date. You can still sign in using your confirmation code. Please call reception if you do not know your confirmation code, and we will be happy to help you."
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
    
    // MARK: - Actions
    
    @objc private func cancelBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneBarButtonItemTapped() {
        associateReservationByConfirmationCode(completion: handleReservationAssociationResponse)
    }
    
    @objc private func addBookingConfirmationButtonTapped() {
        associateReservationByConfirmationCode(completion: handleReservationAssociationResponse)
    }
    
    // MARK: - Private instance methods
    
    private func associateReservationByConfirmationCode(completion: @escaping (_ didSucceed: Bool) -> Void) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var reservationAssociationURLComponents = ReservationAssociationByConfirmationCodeViewController.urlComponents
        reservationAssociationURLComponents.path = "/api/v0/reservation_associations"
        
        let parameters: Parameters = [
            "reservation": [
                "confirmation_code": confirmationCodeTextField.text
            ]
        ]
        
        sessionManager.request(reservationAssociationURLComponents.url!,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(_):
                    completion(false)
                }
        }
    }
    
    private func handleReservationAssociationResponse(didSucceed: Bool) {
        if didSucceed {
            dismiss(animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error Associating Reservation", message: "Please check that the confirmation code is correct.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}
