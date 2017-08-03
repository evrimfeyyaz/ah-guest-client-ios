//
//  Created by Evrim Persembe on 5/2/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCartFooterView: UIView {
    
    // MARK: - Public properties
    
    let totalPriceLabel = StyledLabel(withStyle: .price)
    let addMoreItemsButton = ThemeViewFactory.hollowButton()
    let checkoutButton = ThemeViewFactory.filledButton()
    
    // MARK: - Private properties
    
    private let totalTextLabel = StyledLabel(withStyle: .body)
    private let upperStackView = UIStackView()
    private let lowerStackView = UIStackView()

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func configureView() {
        configureTotalTextLabel()
        configureTotalPriceLabel()
        configureUpperStackView()
        configureAddMoreItemsButton()
        configureCheckoutButton()
        configureLowerStackView()
        configureOuterStackView()
    }
    
    private func configureTotalTextLabel() {
        totalTextLabel.text = "Total"
        totalTextLabel.textAlignment = .right
    }
    
    private func configureTotalPriceLabel() {
        totalPriceLabel.text = Decimal(0).stringInBahrainiDinars
        totalPriceLabel.textAlignment = .right
    }
    
    private func configureUpperStackView() {
        upperStackView.addArrangedSubview(totalTextLabel)
        upperStackView.addArrangedSubview(totalPriceLabel)
        upperStackView.spacing = 5
        upperStackView.alignment = .firstBaseline
    }
    
    private func configureAddMoreItemsButton() {
        addMoreItemsButton.setTitle("Add More Items", for: .normal)
    }
    
    private func configureCheckoutButton() {
        checkoutButton.setTitle("Place Order", for: .normal)
    }
    
    private func configureLowerStackView() {
        lowerStackView.addArrangedSubview(checkoutButton)
        lowerStackView.addArrangedSubview(addMoreItemsButton)
        lowerStackView.alignment = .center
        lowerStackView.spacing = 10
        lowerStackView.axis = .vertical
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [upperStackView, lowerStackView])
        outerStackView.axis = .vertical
        outerStackView.spacing = 5
        
        addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            outerStackView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -30)
            ])
    }
}
