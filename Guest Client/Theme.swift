//
//  KHotelStyles.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class Theme {
    
    static let titleTwoFont = UIFont(name: "Oswald", size: 24)
    static let titleTwoTextColor = UIColor.white
    
    static let bodyFont = UIFont(name: "Lato-Light", size: 17)
    static let bodyTextColor = UIColor.white
    
    static let navigationButtonFont = UIFont(name: "Lato-Light", size: 17)
    static let navigationButtonTextColorNormalState = UIColor.white
    static let navigationButtonTextColorHighlightedState = UIColor.white
}

extension Theme {
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
