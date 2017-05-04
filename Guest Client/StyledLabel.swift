//
//  StyledLabel.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/17/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class StyledLabel: UILabel {

    // MARK: - Public properties
    
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
    
    override var textAlignment: NSTextAlignment {
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func styleLabel() {
        switch style {
        case .title1:
            attributedText = getAttributedString(withLineSpacing: 1.0, withLineHeightMultiple: 0.8)
            font = ThemeFonts.oswaldRegular.withSize(36)
            textColor = .white
        case .title2:
            attributedText = getAttributedString(withLineSpacing: 1.0, withLineHeightMultiple: 0.8, withTextAlignment: .left)
            font = ThemeFonts.oswaldRegular.withSize(24)
            textColor = .white
        case .body:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
            textColor = .white
        case .bodySmall:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 14)
            textColor = .white
        case .cellTitle:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoRegular, withSize: 16)
            textColor = .white
        case .cellDescription:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLightItalic, withSize: 14)
            textColor = .white
        case .cellDetail:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 16)
            textColor = UIColor.white.withAlphaComponent(0.7)
        case .cellPrice:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 14)
            textColor = .white
        case .price:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 18)
            textColor = .white
        case .tableHeader:
            font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 13)
            textColor = UIColor.white.withAlphaComponent(0.4)
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
        
        if let textAlignment = textAlignment {
            paragraphStyle.alignment = textAlignment
        } else {
            // If the user has set the alignment on the label,
            // use this setting on the attributed string as well.
            paragraphStyle.alignment = self.textAlignment
        }
        
        let attrString = NSMutableAttributedString(string: text ?? "")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
}

enum LabelStyle {
    case title1
    case title2
    case body
    case bodySmall
    case cellTitle
    case cellDescription
    case cellDetail
    case cellPrice
    case price
    case tableHeader
    case attribute
}
