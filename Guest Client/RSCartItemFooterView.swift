//
//  RSCartItemFooter.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCartItemFooterView: UIView {

    // MARK: - Public properties
    
    let addToCartButton = ThemeViewFactory.filledButton()
    let totalPriceLabel = StyledLabel(withStyle: .bodySmall)
    
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
        configureStackView()
        configureAddToCartButton()
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [totalPriceLabel, addToCartButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -15)
            ])
    }
    
    private func configureAddToCartButton() {
        addToCartButton.setTitle("Add to Cart", for: .normal)
    }

}
