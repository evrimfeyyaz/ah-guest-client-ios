//
//  ThemeColors.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeColors {
    
    static let darkBlue = uiColorFromRgb(rgbValue: 0x00171F)
    static let blackRock = uiColorFromRgb(rgbValue: 0x2B2F3D)
    static let maroon = uiColorFromRgb(rgbValue: 0x8B2131)
    static let lightPink = uiColorFromRgb(rgbValue: 0xFFE2E2)
    
    // From: http://stackoverflow.com/a/24074509
    static func uiColorFromRgb(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
