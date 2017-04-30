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
    
    // MARK: - Private properties
    
    var innerStackView = UIStackView()
    
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
        configureInnerStackView()
        configureOuterStackView()
    }
    
    private func configureTitleLabel() {
        itemTitleLabel.numberOfLines = 0
        // I have absolutely no idea why, but the following is the only way to make this work.
        itemTitleLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
    }
    
    private func configurePriceLabel() {
        itemPriceLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
    }
    
    private func configureInnerStackView() {
        innerStackView.addArrangedSubview(itemTitleLabel)
        innerStackView.addArrangedSubview(itemPriceLabel)
        innerStackView.distribution = .fill
        innerStackView.alignment = .firstBaseline
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [innerStackView, itemDescriptionLabel])
        outerStackView.axis = .vertical
        outerStackView.distribution = .equalSpacing
        
        contentView.addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            outerStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
}
