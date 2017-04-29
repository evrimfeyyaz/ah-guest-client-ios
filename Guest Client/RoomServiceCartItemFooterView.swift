//
//  RSCartItemFooter.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCartItemFooterView: UIView {

    let addToCartButton = ThemeViewFactory.filledButton()
    let totalPriceLabel = StyledLabel(withStyle: .bodySmall)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(totalPriceLabel)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            totalPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
        addSubview(addToCartButton)
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 5),
            addToCartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToCartButton.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -15)
            ])
    }

}
