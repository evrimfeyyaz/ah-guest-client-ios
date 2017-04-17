//
//  TagLabel.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/15/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class AttributeView: UIView {
    
    var title: String? {
        didSet {
            setUpTitleLabel()
        }
    }
    
    var titleLabel: UILabel = {
        let styledLabel = StyledLabel()
        styledLabel.style = .attribute
        
        return styledLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    func setUp() {
        setUpView()
        setUpTitleLabel()
    }
    
    func setUpView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    func setUpTitleLabel() {
        titleLabel.text = title?.uppercased()
        titleLabel.accessibilityLabel = title
        titleLabel.textAlignment = .center
    }
    
    override func didMoveToSuperview() {
        // Ridiculous but necessary: http://stackoverflow.com/questions/32694124/auto-layout-layoutmarginsguide
        layoutMargins = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
    }
    
}
