//
//  TagLabel.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/15/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class AttributeView: UIView {
    
    // MARK: - Public properties
    
    var title: String? {
        didSet {
            updateTitleLabelText()
        }
    }
    
    // MARK: - Private properties
    
    private var titleLabel = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: CGRect.zero)
        
        configureView()
    }
    
    init(title: String) {
        self.title = title
        
        super.init(frame: CGRect.zero)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func configureView() {
        backgroundColor = .white
        
        configureTitleLabel()
        updateTitleLabelText()
    }
    
    private func configureTitleLabel() {
        titleLabel.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 14)
        titleLabel.textColor = ThemeColors.darkBlue
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func updateTitleLabelText() {
        layer.cornerRadius = titleLabel.font.pointSize / 1.5
        
        titleLabel.text = title?.uppercased()
        titleLabel.accessibilityLabel = title
        titleLabel.textAlignment = .center
    }
    
    override func didMoveToSuperview() {
        // Ridiculous but necessary: http://stackoverflow.com/questions/32694124/auto-layout-layoutmarginsguide
        layoutMargins = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
    }
    
}
