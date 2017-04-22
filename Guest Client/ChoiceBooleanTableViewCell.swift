//
//  ChoiceBooleanTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ChoiceBooleanTableViewCell: UITableViewCell {

    let titleLabel = StyledLabel(withStyle: .cellTitle)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
            ])
    }

}
