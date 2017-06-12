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
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
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
        titleLabel.text = "Welcome, \(APIManager.shared.currentUser!.firstName)."
        titleLabel.numberOfLines = 0
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "Please choose your check-in date below."
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
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    // MARK: - Actions
    @objc private func cancelBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneBarButtonItemTapped() {
        associateReservationByCheckInDate()
    }
    
    @objc private func associateReservationButtonTapped() {
        associateReservationByCheckInDate()
    }
    
    // MARK: - Private instance methods
    private func associateReservationByCheckInDate() {
        APIManager.shared.createReservationAssociation(byCheckInDate: checkInDatePicker.date) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success:
                guard APIManager.shared.currentUser?.currentReservation != nil
                    else {
                        self.show(ReservationAssociationByConfirmationCodeViewController(), sender: nil)
                        return
                }
                
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                switch error {
                case APIManagerError.apiProvidedError:
                    self.show(ReservationAssociationByConfirmationCodeViewController(), sender: nil)
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
