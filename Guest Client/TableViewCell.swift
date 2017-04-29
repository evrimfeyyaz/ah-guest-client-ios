//
//  ChoiceBooleanTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let descriptionLabel = StyledLabel(withStyle: .cellDescription)
    let detailLabel = StyledLabel(withStyle: .cellDetail)
    
    private var detailLabelTrailingConstraintWithoutAccessory: NSLayoutConstraint?
    private var detailLabelTrailingConstraintWithAccessory: NSLayoutConstraint?
    
    override var accessoryType: UITableViewCellAccessoryType {
        didSet {
            toggleAppropriateTrailingConstraintForDetailLabel()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        selectionStyle = .none
        tintColor = .white
        
        // Set up the title label.
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: -1), // -1 is needed to make the font size match with the vertical center of the accessory.
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
        
        // Set up the detail label.
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabelTrailingConstraintWithoutAccessory = detailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        detailLabelTrailingConstraintWithAccessory = detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        toggleAppropriateTrailingConstraintForDetailLabel()
        
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.leadingAnchor, constant: 15),
            detailLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
//            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        // Set up the description label.
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    func toggleAppropriateTrailingConstraintForDetailLabel() {
        if accessoryType == .none {
            detailLabelTrailingConstraintWithAccessory?.isActive = false
            detailLabelTrailingConstraintWithoutAccessory?.isActive = true
        } else {
            detailLabelTrailingConstraintWithoutAccessory?.isActive = false
            detailLabelTrailingConstraintWithAccessory?.isActive = true
        }
    }

}
