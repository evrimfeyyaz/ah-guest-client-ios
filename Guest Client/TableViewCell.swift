//
//  ChoiceBooleanTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let descriptionLabel = StyledLabel(withStyle: .cellDescription)
    let detailLabel = StyledLabel(withStyle: .cellDetail)
    
    override var accessoryType: UITableViewCellAccessoryType {
        didSet {
            toggleAppropriateTrailingConstraintForDetailLabel()
        }
    }
    
    // MARK: - Private properties
    
    private var detailLabelTrailingConstraintWithoutAccessory: NSLayoutConstraint?
    private var detailLabelTrailingConstraintWithAccessory: NSLayoutConstraint?
    
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
        tintColor = .white
        
        configureTitleLabel()
        configureDetailLabel()
        configureDescriptionLabel()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: -1), // -1 is needed to make the font size match with the vertical center of the accessory.
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureDetailLabel() {
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.leadingAnchor, constant: 15),
            detailLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
            ])
        
        // This is so that when there is an accessory, the detail label is not too far from it.
        detailLabelTrailingConstraintWithoutAccessory = detailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        detailLabelTrailingConstraintWithAccessory = detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        toggleAppropriateTrailingConstraintForDetailLabel()
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func toggleAppropriateTrailingConstraintForDetailLabel() {
        if accessoryType == .none {
            detailLabelTrailingConstraintWithAccessory?.isActive = false
            detailLabelTrailingConstraintWithoutAccessory?.isActive = true
        } else {
            detailLabelTrailingConstraintWithoutAccessory?.isActive = false
            detailLabelTrailingConstraintWithAccessory?.isActive = true
        }
    }

}
