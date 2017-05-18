//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class AddStayViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let labelStackView = UIStackView()
    private let inputContainerView = UIView()
    private let roomNumberTextField = ThemeViewFactory.textField()
    private let addBookingConfirmationButton = ThemeViewFactory.filledButton()
    
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
        configureBookingConfirmationTextField()
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
        titleLabel.text = "Welcome, Evrim"
        titleLabel.numberOfLines = 0
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "Please enter your room number below."
        explanationLabel.numberOfLines = 0
    }
    
    private func configureLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(explanationLabel)
        
        labelStackView.axis = .vertical
    }
    
    private func configureBookingConfirmationTextField() {
        roomNumberTextField.attributedPlaceholder = NSAttributedString(string: "Room Number",
                                                                       attributes: [
                                                                        NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                                        NSFontAttributeName: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 15)])
        roomNumberTextField.keyboardType = .numberPad
        
        inputContainerView.addSubview(roomNumberTextField)
        roomNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNumberTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor),
            roomNumberTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor),
            roomNumberTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            roomNumberTextField.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            roomNumberTextField.heightAnchor.constraint(equalToConstant: 46)
            ])
    }
    
    private func configureAddBookingConfirmationButton() {
        addBookingConfirmationButton.setTitle("Done", for: .normal)
        addBookingConfirmationButton.addTarget(self, action: #selector(addBookingConfirmationButtonTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView, inputContainerView, addBookingConfirmationButton])
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
        addBookingConfirmation()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addBookingConfirmationButtonTapped() {
        addBookingConfirmation()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private instance methods
    
    private func addBookingConfirmation() {
        RSCart.shared.isSignedIn = true
    }
}
