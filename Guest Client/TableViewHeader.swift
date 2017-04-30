//
//  TableViewHeader.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Public properties
    
    let titleLabel = StyledLabel(withStyle: .tableHeader)
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View configuration
    
    private func configureView() {
        // This is needed to make the background transparent.
        backgroundView = UIView(frame: bounds)
        backgroundView?.backgroundColor = .clear
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

}
