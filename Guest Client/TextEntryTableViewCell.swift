//
//  TextEntryTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TextEntryTableViewCell: UITableViewCell {

    // MARK: - Public properties
    
    let titleLabel = StyledLabel(withStyle: .cellTitle)
    let textView = ThemeViewFactory.textView()
    
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
        
        configureTextView()
        configureStackView()
    }
    
    private func configureTextView() {
        textView.isEditable = true
        textView.isScrollEnabled = false
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textView])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }

}
