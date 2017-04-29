//
//  RSItemTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItemTableViewCell: UITableViewCell {
    
    private let itemTitleLabel = StyledLabel(withStyle: .cellTitle)
    private let itemDescriptionLabel = StyledLabel(withStyle: .cellDescription)
    private let itemPriceLabel = StyledLabel(withStyle: .cellPrice)

    var itemTitle: String {
        get { return itemTitleLabel.text ?? "" }
        set { itemTitleLabel.text = newValue }
    }
    
    var itemDescription: String? {
        get { return itemDescriptionLabel.text }
        set { itemDescriptionLabel.text = newValue }
    }
    
    var itemPrice: String {
        get { return itemPriceLabel.text ?? "" }
        set { itemPriceLabel.text = newValue }
    }
    
    var itemId: Int?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpViews()
    }
    
    func setUpViews() {
        // Set up the item title label.
        contentView.addSubview(itemTitleLabel)
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
            ])
        
        // Set up the item price label.
        contentView.addSubview(itemPriceLabel)
        itemPriceLabel.setContentCompressionResistancePriority(751, for: .horizontal)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            itemPriceLabel.firstBaselineAnchor.constraint(equalTo: itemTitleLabel.firstBaselineAnchor),
            itemPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: itemTitleLabel.trailingAnchor, constant: 15)
            ])
        
        // Set up the item description label.
        contentView.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
}
