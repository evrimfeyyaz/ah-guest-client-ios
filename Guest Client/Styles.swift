//
//  KHotelStyles.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class Colors {
    
    static let titleText = UIColor.white
    static let bodyText = UIColor.white
    static let navigationButtonColorNormalState = UIColor.white
    static let navigationButtonColorHighlightedState = UIColor.white
    
    static let navigationBarBackground = StyleHelpers.UIColorFromRgb(rgbValue: 0x8B2131)
    static let navigationBarTitle = UIColor.white
    
}

class Fonts {
    
    static let titleTwo = UIFont(name: "Oswald", size: 24)
    static let body = UIFont(name: "Lato-Light", size: 17)
    static let navigationButton = UIFont(name: "Lato-Light", size: 17)
    static let navigationBarTitle = UIFont(name: "Lato", size: 17)
    
}

class StyleHelpers {
    // From: http://stackoverflow.com/a/24074509
    static func UIColorFromRgb(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
