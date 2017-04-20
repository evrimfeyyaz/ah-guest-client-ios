//
//  RoomServiceItemTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
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
        // TODO: Refactor this into a protocol.
        // Set up the container view to show a margin below the cell.
        contentView.addSubview(containerView)
        containerView.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
            ])
        
        // Set up the item title label.
        containerView.addSubview(itemTitleLabel)
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor)
            ])
        
        // Set up the item price label.
        containerView.addSubview(itemPriceLabel)
        itemPriceLabel.setContentCompressionResistancePriority(751, for: .horizontal)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            itemPriceLabel.firstBaselineAnchor.constraint(equalTo: itemTitleLabel.firstBaselineAnchor),
            itemPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: itemTitleLabel.trailingAnchor, constant: 15)
            ])
        
        // Set up the item description label.
        containerView.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
}
