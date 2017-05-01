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
        
        configureStackView()
        configureQuantityLabel()
        configureQuantityStepper()
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, quantityLabel, quantityStepper])
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureQuantityLabel() {
        quantityLabel.text = String(1)
    }
    
    private func configureQuantityStepper() {
        quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged), for: .valueChanged)
        quantityStepper.tintColor = .white
        quantityStepper.minimumValue = 1
    }
    
    // MARK: - Actions
    
    @objc private func quantityStepperValueChanged() {
        quantityLabel.text = String(format: "%.0f", quantityStepper.value)
    }
}
