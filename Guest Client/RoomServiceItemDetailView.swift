//
//  RoomServiceItemDetailView.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/22/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemDetailView: UIView {

    let itemTitleLabel = StyledLabel(withStyle: .titleOne)
    let itemAttributesView = UIStackView()
    let itemPriceLabel = StyledLabel(withStyle: .price)
    let itemDescriptionLabel = StyledLabel(withStyle: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        // Set up the item title label.
        addSubview(itemTitleLabel)
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            itemTitleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -10),
            itemTitleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15)
            ])
        
        // Set up the item attributes 
        addSubview(itemAttributesView)
        itemAttributesView.translatesAutoresizingMaskIntoConstraints = false
        itemAttributesView.alignment = .center
        itemAttributesView.distribution = .equalSpacing
        itemAttributesView.spacing = 10
        NSLayoutConstraint.activate([
            itemAttributesView.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemAttributesView.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 2)
            ])
        
        // Set up the item price label.
        addSubview(itemPriceLabel)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor),
            itemPriceLabel.centerYAnchor.constraint(equalTo: itemAttributesView.centerYAnchor),
            itemPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: itemAttributesView.trailingAnchor, constant: 15)
            ])
        
        // Set up the item description label.
        addSubview(itemDescriptionLabel)
        itemDescriptionLabel.numberOfLines = 0
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemAttributesView.bottomAnchor, constant: 6),
            itemDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -15)
            ])
    }
    
}
