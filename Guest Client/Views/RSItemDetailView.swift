//
//  RSItemDetailView.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/22/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import TagListView

class RSItemDetailView: UIView {
    
    // MARK: - Public properties

    let itemTitleLabel = StyledLabel(withStyle: .title1)
    let tagListView = TagListView()
    let tagCellIdentifier = "TagCell"
    let itemPriceLabel = StyledLabel(withStyle: .price)
    let itemDescriptionLabel = StyledLabel(withStyle: .body)
    
    // MARK: - Private properties
    
    private let centerStackView = UIStackView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration

    private func configureView() {
        configureTitleLabel()
        configureDescriptionLabel()
        configureTagListView()
        configureCenterStackView()
        configureOuterStackView()
    }
    
    private func configureTagListView() {
        tagListView.textFont = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 14)
        tagListView.textColor = ThemeColors.darkBlue
        tagListView.tagBackgroundColor = .white
        tagListView.paddingX = 10
        tagListView.paddingY = 5
        tagListView.marginX = 5
        tagListView.marginY = 10
        tagListView.cornerRadius = tagListView.textFont.pointSize / 1.5
        tagListView.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
    }
    
    private func configureCenterStackView() {
        centerStackView.addArrangedSubview(tagListView)
        centerStackView.addArrangedSubview(itemPriceLabel)
        centerStackView.distribution = .fill
        centerStackView.alignment = .center
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [itemTitleLabel, centerStackView, itemDescriptionLabel])
        outerStackView.axis = .vertical
        outerStackView.spacing = 6
        
        addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            outerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -10),
            outerStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            outerStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -30)
            ])
    }
    
    private func configureTitleLabel() {
        itemTitleLabel.numberOfLines = 0
    }
    
    private func configureDescriptionLabel() {
        itemDescriptionLabel.numberOfLines = 0
    }
    
}
