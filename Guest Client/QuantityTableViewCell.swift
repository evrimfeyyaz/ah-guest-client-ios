//
//  QuantityTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {
    
    // MARK: - Private properties

    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let quantityLabel = StyledLabel(withStyle: .cellDetail)
    let quantityStepper = UIStepper()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func configureView() {
        selectionStyle = .none
        
//        let stackView = UIStackView(arrangedSubviews: [titleLabel, quantityLabel, quantityStepper])
        
        configureTitleLabel()
        configureQuantityLabel()
        configureQuantityStepper()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureQuantityLabel() {
        contentView.addSubview(quantityLabel)
        quantityLabel.text = String(1)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    private func configureQuantityStepper() {
        contentView.addSubview(quantityStepper)
        quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged), for: .valueChanged)
        quantityStepper.tintColor = .white
        quantityStepper.minimumValue = 1
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityStepper.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 10),
            quantityStepper.centerYAnchor.constraint(greaterThanOrEqualTo: quantityLabel.centerYAnchor),
            quantityStepper.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
    // MARK: - Actions
    
    @objc private func quantityStepperValueChanged() {
        quantityLabel.text = String(format: "%.0f", quantityStepper.value)
    }
}
