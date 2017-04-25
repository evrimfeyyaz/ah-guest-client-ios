//
//  TextEntryTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TextEntryTableViewCell: UITableViewCell {

    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let textView = TextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        selectionStyle = .none
        
        // Set up the title label.
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
            ])
        
        // Set up the text view.
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }

}
