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
        let proxyTitleTwoLabel = TitleTwoLabel.appearance()
        proxyTitleTwoLabel.font = Fonts.titleTwo
        proxyTitleTwoLabel.textColor = Colors.titleText
        
        let proxyBodyLabel = BodyLabel.appearance()
        proxyBodyLabel.font = Fonts.body
        proxyBodyLabel.textColor = Colors.bodyText
        
        let proxyStyledNavigationBar = StyledNavigationBar.appearance()
        proxyStyledNavigationBar.barTintColor = Colors.navigationBarBackground
        proxyStyledNavigationBar.isTranslucent = false
        proxyStyledNavigationBar.titleTextAttributes = [
            NSFontAttributeName: Fonts.navigationBarTitle!,
            NSForegroundColorAttributeName: Colors.navigationBarTitle
        ]
        
        let proxyNavigationButton = NavigationButton.appearance()
        proxyNavigationButton.titleLabelFont = Fonts.navigationButton
        proxyNavigationButton.titleColorNormalState = Colors.navigationButtonColorNormalState
        proxyNavigationButton.titleColorHighlightedState = Colors.navigationButtonColorHighlightedState
        
    }
    
}
