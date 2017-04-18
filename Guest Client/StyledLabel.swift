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
    @IBInspectable var styleAsString: String = "" {
        didSet {
            switch styleAsString {
            case "Title 1":
                style = .titleOne
            case "Title 2":
                style = .titleTwo
            case "Body":
                style = .body
            case "Cell Title":
                style = .cellTitle
            case "Cell Description":
                style = .cellDescription
            case "Cell Price":
                style = .cellPrice
            case "Price":
                style = .price
            case "Table Header":
                style = .tableHeader
            case "Attribute":
                style = .attribute
            default:
                style = .body
            }
        }
    }
    
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
    
    // MARK: - Private Functions
    private func styleLabel() {
        switch style {
        case .titleOne:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = 0.8
            
            let attrString = NSMutableAttributedString(string: text ?? "")
            attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            
            attributedText = attrString
            
            font = Fonts.oswaldRegular.withSize(36)
            textColor = Colors.white
        case .titleTwo:
            font = Fonts.oswaldRegular.withSize(24)
            textColor = Colors.white
        case .body:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.latoLight, withSize: 17)
            textColor = Colors.white
        case .cellTitle:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.latoRegular, withSize: 16)
            textColor = Colors.white
        case .cellDescription:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.latoLightItalic, withSize: 14)
            textColor = Colors.white
        case .cellPrice:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.oswaldRegular, withSize: 14)
            textColor = Colors.white
        case .price:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.oswaldRegular, withSize: 18)
            textColor = Colors.white
        case .tableHeader:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.oswaldRegular, withSize: 15)
            textColor = Colors.white.withAlphaComponent(0.7)
        case .attribute:
            font = Fonts.dynamicEquivalent(ofFont: Fonts.oswaldRegular, withSize: 14)
            textColor = Colors.darkBlue
        }
    }
    
}

enum LabelStyle {
    case titleOne
    case titleTwo
    case body
    case cellTitle
    case cellDescription
    case cellPrice
    case price
    case tableHeader
    case attribute
}
