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
        navigationBar.barTintColor = ThemeColors.maroon
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: ThemeFonts.latoRegular.withSize(17),
            NSForegroundColorAttributeName: ThemeColors.lightPink
        ]
        navigationBar.tintColor = .white
        
        let navigationBarButton = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        navigationBarButton.setTitleTextAttributes([
            NSFontAttributeName: ThemeFonts.latoLight.withSize(17),
            NSForegroundColorAttributeName: UIColor.white
            ], for: .normal)
    }
    
}
