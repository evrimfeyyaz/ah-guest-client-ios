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
            toggleAppropriateTrailingConstraint()
        }
    }
    
    // MARK: - Private properties
    
    private var trailingConstraintWithoutAccessory: NSLayoutConstraint?
    private var trailingConstraintWithAccessory: NSLayoutConstraint?
    
    private let upperStackView = UIStackView()
    
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
        
        configureUpperStackView()
        configureOuterStackView()
    }

    private func configureUpperStackView() {
        upperStackView.addArrangedSubview(titleLabel)
        upperStackView.addArrangedSubview(detailLabel)
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [upperStackView, descriptionLabel])
        outerStackView.axis = .vertical
        
        contentView.addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            // The -1 below is to adjust the baseline to match with the center of the accessory.
            outerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: -1),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
        
        // This is so that when there is an accessory, there isn't a big gap between it and the detail label.
        trailingConstraintWithoutAccessory = outerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        trailingConstraintWithAccessory = outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        toggleAppropriateTrailingConstraint()
    }
    
    private func toggleAppropriateTrailingConstraint() {
        if accessoryType == .none {
            trailingConstraintWithAccessory?.isActive = false
            trailingConstraintWithoutAccessory?.isActive = true
        } else {
            trailingConstraintWithoutAccessory?.isActive = false
            trailingConstraintWithAccessory?.isActive = true
        }
    }

}
