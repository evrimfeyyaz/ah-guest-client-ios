//
//  StyledLabel.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/17/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class StyledLabel: UILabel {

    // MARK: - Properties
    var style: LabelStyle = .body {
        didSet {
            styleLabel()
        }
    }
    
    override var text: String? {
        didSet {
            styleLabel()
        }
    }
    
    // MARK: Initializers
    init(withStyle style: LabelStyle) {
        super.init(frame: CGRect.zero)
        
        self.style = style
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private methods
    private func styleLabel() {
        switch style {
        case .titleOne:
            attributedText = getAttributedString(withLineSpacing: 1.0, withLineHeightMultiple: 0.8)
            
            font = ThemeFonts.oswaldRegular.withSize(36)
            textColor = ThemeColors.white
        case .titleTwo:
            attributedText = getAttributedString(withLineSpacing: 1.0, withLineHeightMultiple: 0.8, withTextAlignment: .center)
            
            font = ThemeFonts.oswaldRegular.withSize(24)
            textColor = ThemeColors.white
        case .body:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
            textColor = ThemeColors.white
        case .cellTitle:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoRegular, withSize: 16)
            textColor = ThemeColors.white
        case .cellDescription:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 14)
            textColor = ThemeColors.white
        case .cellDetail:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 16)
            textColor = ThemeColors.white.withAlphaComponent(0.7)
        case .cellPrice:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 14)
            textColor = ThemeColors.white
        case .price:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 18)
            textColor = ThemeColors.white
        case .tableHeader:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 13)
            textColor = ThemeColors.white.withAlphaComponent(0.4)
        case .attribute:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 14)
            textColor = ThemeColors.darkBlue
        }
    }
    
    private func getAttributedString(withLineSpacing lineSpacing: CGFloat,
                                     withLineHeightMultiple lineHeightMultiple: CGFloat,
                                     withTextAlignment textAlignment: NSTextAlignment? = nil) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = 0.8
        
        // If the user has set the alignment on the label,
        // use this setting on the attributed string as well.
        if let textAlignment = textAlignment {
            paragraphStyle.alignment = textAlignment
        }
        
        let attrString = NSMutableAttributedString(string: text ?? "")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
}

enum LabelStyle {
    case titleOne
    case titleTwo
    case body
    case cellTitle
    case cellDescription
    case cellDetail
    case cellPrice
    case price
    case tableHeader
    case attribute
}
