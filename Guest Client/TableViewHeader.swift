//
//  TableViewHeader.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    let titleLabel = StyledLabel(withStyle: .tableHeader)
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpViews()
    }

    func setUpViews() {
        // This is needed to make the background transparent.
        backgroundView = UIView(frame: bounds)
        backgroundView?.backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
