//
//  ThemeFonts.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeFonts {
    
    static let oswaldRegular = font(withName: "Oswald")
    static let latoRegular = font(withName: "Lato")
    static let latoLight = font(withName: "Lato-Light")
    static let latoLightItalic = font(withName: "Lato-LightItalic")
    
    // From: http://stackoverflow.com/a/33114525
    static var fontSizeMultiplier : CGFloat {
        get {
            switch UIApplication.shared.preferredContentSizeCategory {
            case UIContentSizeCategory.accessibilityExtraExtraExtraLarge: return 23 / 16
            case UIContentSizeCategory.accessibilityExtraExtraLarge: return 22 / 16
            case UIContentSizeCategory.accessibilityExtraLarge: return 21 / 16
            case UIContentSizeCategory.accessibilityLarge: return 20 / 16
            case UIContentSizeCategory.accessibilityMedium: return 19 / 16
            case UIContentSizeCategory.extraExtraExtraLarge: return 19 / 16
            case UIContentSizeCategory.extraExtraLarge: return 18 / 16
            case UIContentSizeCategory.extraLarge: return 17 / 16
            case UIContentSizeCategory.large: return 1.0
            case UIContentSizeCategory.medium: return 15 / 16
            case UIContentSizeCategory.small: return 14 / 16
            case UIContentSizeCategory.extraSmall: return 13 / 16
            default: return 1.0
            }
        }
    }
    
    static func font(withName name: String, size: CGFloat = 13) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func dynamicEquivalent(ofFont font: UIFont, withSize size: CGFloat) -> UIFont {
        return font.withSize(fontSizeMultiplier * size)
    }
    
}
