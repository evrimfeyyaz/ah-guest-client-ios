//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class ReservationAssociationByCheckInDateViewController: UIViewController {
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let labelStackView = UIStackView()
    private let inputContainerView = UIView()
    private let checkInDatePicker = ThemeViewFactory.datePicker()
    private let associateReservationButton = ThemeViewFactory.filledButton()
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
        configureCheckInDatePicker()
        configureAddBookingConfirmationButton()
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
        let stackView = UIStackView(arrangedSubviews: [labelStackView, inputContainerView, associateReservationButton])
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
        associateReservationByCheckInDate()
    }
    
    @objc private func associateReservationButtonTapped() {
        associateReservationByCheckInDate()
    }
    
    // MARK: - Private instance methods
    private func associateReservationByCheckInDate() {
        activityIndicatorView.startAnimating()
        
        APIManager.shared.createReservationAssociation(byCheckInDate: checkInDatePicker.date) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success:
                self.dismiss(animated: true, completion: self.successCallback)
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet {
                    let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
                        self?.associateReservationByCheckInDate()
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true)
                    
                    break
                }
                
                switch error {
                case APIManagerError.apiProvidedError:
                    self.showReservationAssociationByConfirmationCodeViewController()
                default:
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    private func showReservationAssociationByConfirmationCodeViewController() {
        let reservationAssociationByConfirmationCodeVC = ReservationAssociationByConfirmationCodeViewController()
        reservationAssociationByConfirmationCodeVC.successCallback = successCallback
        self.show(reservationAssociationByConfirmationCodeVC, sender: nil)
    }
}
