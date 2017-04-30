//
//  RSItemTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItemTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    let itemTitleLabel = StyledLabel(withStyle: .cellTitle)
    let itemDescriptionLabel = StyledLabel(withStyle: .cellDescription)
    let itemPriceLabel = StyledLabel(withStyle: .cellPrice)
    
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
        configureTitleLabel()
        configurePriceLabel()
        configureDescriptionLabel()
    }
    
    private func configureTitleLabel() {
        itemTitleLabel.numberOfLines = 0
        
        contentView.addSubview(itemTitleLabel)
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
            ])
    }
    
    private func configurePriceLabel() {
        contentView.addSubview(itemPriceLabel)
        itemPriceLabel.setContentCompressionResistancePriority(751, for: .horizontal)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            itemPriceLabel.firstBaselineAnchor.constraint(equalTo: itemTitleLabel.firstBaselineAnchor),
            itemPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: itemTitleLabel.trailingAnchor, constant: 15)
            ])
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
}
