//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSOrderSuccessfulViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let titleLabel = StyledLabel(withStyle: .title1Centered)
    private let explanationLabel = StyledLabel(withStyle: .bodyCentered)
    private let doneButton = ThemeViewFactory.filledButton()
    
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
        configureBackToCartButton()
        configureStackView()
    }
    
    private func configureNavigationBar() {
        let doneBarButtonItem = ThemeViewFactory.doneStyleBarButton(title: "Done",
                                                                    target: self,
                                                                    action: #selector(doneBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = doneBarButtonItem
        navigationItem.hidesBackButton = true
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Thank You For Your Order"
        titleLabel.numberOfLines = 0
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "Your order will be delivered to your room within 30 minutes."
        explanationLabel.numberOfLines = 0
    }
    
    private func configureBackToCartButton() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, explanationLabel, doneButton])
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
    
    @objc private func doneBarButtonItemTapped() {
        emptyCartAndDismiss()
    }
    
    @objc private func doneButtonTapped() {
        emptyCartAndDismiss()
    }
    
    // MARK: - Private instance methods
    
    private func emptyCartAndDismiss() {
        RoomServiceOrder.cart.cartItems = []
        dismiss(animated: true, completion: nil)
    }
    
}
