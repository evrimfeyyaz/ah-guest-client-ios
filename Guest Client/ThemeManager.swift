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
        applyStyleToLabel(appearanceProxy: TitleOneLabel.appearance(), font: Fonts.titleOne!, color: Colors.titleText)
        applyStyleToLabel(appearanceProxy: TitleTwoLabel.appearance(), font: Fonts.titleTwo!, color: Colors.titleText)
        applyStyleToLabel(appearanceProxy: SubtitleLabel.appearance(), font: Fonts.subtitle!, color: Colors.titleText)
        applyStyleToLabel(appearanceProxy: BodyLabel.appearance(), font: Fonts.body!, color: Colors.bodyText)
        
        let proxyMainNavigationBar = MainNavigationBar.appearance()
        proxyMainNavigationBar.barTintColor = Colors.navigationBarBackground
        proxyMainNavigationBar.isTranslucent = false
        proxyMainNavigationBar.titleTextAttributes = [
            NSFontAttributeName: Fonts.navigationBarTitle!,
            NSForegroundColorAttributeName: Colors.navigationBarTitle
        ]
        
        let proxyNavigationButton = NavigationButton.appearance()
        proxyNavigationButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.navigationButton!,
            NSForegroundColorAttributeName: Colors.navigationButtonColorNormalState
            ], for: .normal)
        proxyNavigationButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.navigationButton!,
            NSForegroundColorAttributeName: Colors.navigationButtonColorHighlightedState
            ], for: .highlighted)
        
        let proxyClearNavigationBar = ClearNavigationBar.appearance()
        proxyClearNavigationBar.backgroundColor = .clear
        proxyClearNavigationBar.isTranslucent = true
        proxyClearNavigationBar.shadowImage = UIImage()
        proxyClearNavigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    static func applyStyleToLabel(appearanceProxy proxy: UILabel, font: UIFont, color: UIColor) {
        proxy.font = font
        proxy.textColor = color
    }
    
}
