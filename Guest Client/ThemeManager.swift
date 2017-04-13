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
        applyStyleToLabel(appearanceProxy: CellLabel.appearance(), font: Fonts.cell!, color: Colors.bodyText)
        applyStyleToLabel(appearanceProxy: PriceLabel.appearance(), font: Fonts.price!, color: Colors.bodyText)
        applyStyleToLabel(appearanceProxy: SectionLabel.appearance(), font: Fonts.section!, color: Colors.bodyText)
        SectionLabel.appearance(whenContainedInInstancesOf: [UIView.self]).font = Fonts.section!
        
        let proxyMainNavigationBar = MainNavigationBar.appearance()
        proxyMainNavigationBar.barTintColor = Colors.navigationBarBackground
        proxyMainNavigationBar.isTranslucent = false
        proxyMainNavigationBar.titleTextAttributes = [
            NSFontAttributeName: Fonts.navigationBarTitle!,
            NSForegroundColorAttributeName: Colors.navigationBarTitle
        ]
        
        let proxyClearNavigationBar = ClearNavigationBar.appearance()
        proxyClearNavigationBar.backgroundColor = .clear
        proxyClearNavigationBar.isTranslucent = true
        proxyClearNavigationBar.shadowImage = UIImage()
        proxyClearNavigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let testProxy = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        testProxy.setTitleTextAttributes([
            NSFontAttributeName: Fonts.navigationButton!,
            NSForegroundColorAttributeName: Colors.navigationButtonColorNormalState
            ], for: .normal)
        testProxy.setTitleTextAttributes([
            NSFontAttributeName: Fonts.navigationButton!,
            NSForegroundColorAttributeName: Colors.navigationButtonColorHighlightedState
            ], for: .highlighted)
        
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.tintColor = .white
    }
    
    static func applyStyleToLabel(appearanceProxy proxy: UILabel, font: UIFont, color: UIColor) {
        proxy.font = font
        proxy.textColor = color
    }
    
}
