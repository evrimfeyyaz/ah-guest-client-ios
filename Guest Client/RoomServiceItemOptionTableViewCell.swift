//
//  ChoiceBooleanTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemOptionTableViewCell: UITableViewCell {
    
    let titleLabel = StyledLabel(withStyle: .cellTitle)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        // Set up the title label.
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: -1),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }

}

class RoomServiceItemMultipleChoiceOptionTableViewCell: RoomServiceItemOptionTableViewCell {
    
    let choiceLabel = StyledLabel(withStyle: .cellDescription)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        // Set up the description label.
        contentView.addSubview(choiceLabel)
        choiceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            choiceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            choiceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            choiceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
}

class RoomServiceItemSingleChoiceOptionTableViewCell: RoomServiceItemOptionTableViewCell {
    
    let choiceLabel = StyledLabel(withStyle: .cellDetail)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        // Set up the description label.
        contentView.addSubview(choiceLabel)
        choiceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            choiceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.leadingAnchor, constant: 15),
            choiceLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
            choiceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
}
