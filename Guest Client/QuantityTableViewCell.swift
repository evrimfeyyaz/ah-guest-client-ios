//
//  QuantityTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {

    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let quantityLabel = StyledLabel(withStyle: .cellDetail)
    let quantityStepper = UIStepper()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        selectionStyle = .none
        
        // Set up the title label.
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
        
        // Set up the quantity label.
        contentView.addSubview(quantityLabel)
        quantityLabel.text = String(1)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        // Set up the quantity stepper.
        contentView.addSubview(quantityStepper)
        quantityStepper.addTarget(self, action: #selector(updateQuantityLabel), for: .valueChanged)
        quantityStepper.tintColor = .white
        quantityStepper.minimumValue = 1
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityStepper.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 10),
            quantityStepper.centerYAnchor.constraint(greaterThanOrEqualTo: quantityLabel.centerYAnchor),
            quantityStepper.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
    func updateQuantityLabel() {
        quantityLabel.text = String(format: "%.0f", quantityStepper.value)
    }
}
