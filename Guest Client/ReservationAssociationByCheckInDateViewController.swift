//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class ReservationAssociationByCheckInDateViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let labelStackView = UIStackView()
    private let inputContainerView = UIView()
    private let checkInDatePicker = ThemeViewFactory.datePicker()
    private let associateReservationButton = ThemeViewFactory.filledButton()
    
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
        configureCheckInDatePicker()
        configureAddBookingConfirmationButton()
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
        titleLabel.text = "Welcome, \(User.shared!.firstName)."
        titleLabel.numberOfLines = 0
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "Please enter your check-in date below."
        explanationLabel.numberOfLines = 0
    }
    
    private func configureLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(explanationLabel)
        
        labelStackView.axis = .vertical
    }
    
    private func configureCheckInDatePicker() {
        checkInDatePicker.datePickerMode = .date
        
        inputContainerView.addSubview(checkInDatePicker)
        checkInDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkInDatePicker.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor),
            checkInDatePicker.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor),
            checkInDatePicker.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            checkInDatePicker.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            ])
    }
    
    private func configureAddBookingConfirmationButton() {
        associateReservationButton.setTitle("Done", for: .normal)
        associateReservationButton.addTarget(self, action: #selector(associateReservationButtonTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView, inputContainerView, associateReservationButton])
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
        associateReservationByCheckInDate(completion: handleReservationAssociationResponse)
    }
    
    @objc private func associateReservationButtonTapped() {
        associateReservationByCheckInDate(completion: handleReservationAssociationResponse)
    }
    
    // MARK: - Private instance methods
    
    private func associateReservationByCheckInDate(completion: @escaping (_ didSucceed: Bool) -> Void) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var reservationAssociationURLComponents = ReservationAssociationByCheckInDateViewController.urlComponents
        reservationAssociationURLComponents.path = "/api/v0/reservation_associations"
        
        // TODO: Handle locale issues.
        let parameters: Parameters = [
            "reservation": [
                "check_in_date": checkInDatePicker.date.description
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
            show(ReservationAssociationByConfirmationCodeViewController(), sender: nil)
        }
    }
}
