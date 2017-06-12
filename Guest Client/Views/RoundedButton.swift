//
//  Button.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: - Public properties
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.opacity = 0.5
            } else {
                layer.opacity = 1
            }
        }
    }
    
    // MARK: - Initializers
    
    init(cornerRadius: CGFloat, borderWidth: CGFloat,
         backgroundColor: UIColor, borderColor: UIColor, tintColor: UIColor) {
        super.init(frame: CGRect.zero)
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        self.backgroundColor = backgroundColor
        layer.borderColor = borderColor.cgColor
        self.tintColor = tintColor
        
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View configuration
    
    private func configureView() {
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        titleLabel?.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 17)
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title?.uppercased(), for: state)
        
        titleLabel?.accessibilityLabel = title?.uppercased()
    }

}
