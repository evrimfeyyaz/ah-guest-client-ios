//
//  Button.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: - Properties
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = customBackgroundColor.withAlphaComponent(0.5)
                titleLabel?.textColor = customTextColor.withAlphaComponent(0.5)
                layer.borderColor = borderColor.withAlphaComponent(0.5).cgColor
            } else {
                backgroundColor = customBackgroundColor
                titleLabel?.textColor = customTextColor
                layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    var cornerRadius: CGFloat = 5
    var borderThickness: CGFloat = 0
    var customBackgroundColor = UIColor.white
    var borderColor = UIColor.clear
    var customTextColor = UIColor.white
    
    // MARK: - Initializers
    
    init(cornerRadius: CGFloat, borderThickness: CGFloat,
         backgroundColor: UIColor, borderColor: UIColor, textColor: UIColor) {
        super.init(frame: CGRect.zero)
        
        self.cornerRadius = cornerRadius
        self.borderThickness = borderThickness
        self.customBackgroundColor = backgroundColor
        self.borderColor = borderColor
        self.customTextColor = textColor
        
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
    
    func configureView() {
        backgroundColor = customBackgroundColor
        layer.cornerRadius = cornerRadius
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        titleLabel?.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 17)
        titleLabel?.textColor = customTextColor
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title?.uppercased(), for: state)
        
        titleLabel?.accessibilityLabel = title?.uppercased()
    }

}
