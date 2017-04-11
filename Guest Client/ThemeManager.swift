//
//  ThemeManager.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeManager {
    static func applyTheme() {
        let proxyTitleTwoLabel = TitleTwoLabel.appearance()
        proxyTitleTwoLabel.font = KHotelStyles.titleTwoFont
        
        let proxyBodyLabel = BodyLabel.appearance()
        proxyBodyLabel.font = KHotelStyles.bodyFont
    }
}
