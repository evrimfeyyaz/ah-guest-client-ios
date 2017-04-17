//
//  ThemeManager.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeManager {

    static func applyTheme() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = Colors.maroon
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: Fonts.latoRegular.withSize(17),
            NSForegroundColorAttributeName: Colors.white
        ]
        navigationBar.tintColor = .white
        
        let navigationBarButton = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        navigationBarButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.latoLight.withSize(17),
            NSForegroundColorAttributeName: Colors.white
            ], for: .normal)
        navigationBarButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.latoLight.withSize(17),
            NSForegroundColorAttributeName: Colors.white
            ], for: .highlighted)
    }
    
}

class Colors {
    
    static let white = UIColor.white
    static let darkBlue = uiColorFromRgb(rgbValue: 0x00171F)
    static let maroon = uiColorFromRgb(rgbValue: 0x8B2131)
    
    static func uiColorFromRgb(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

class Fonts {
    
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
        print("size \(size)")
        print("dynamic size \(size * fontSizeMultiplier)")
        return font.withSize(fontSizeMultiplier * size)
    }
    
}
