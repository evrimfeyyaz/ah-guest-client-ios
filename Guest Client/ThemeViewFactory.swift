//
//  CustomViewFactory.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/29/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeViewFactory {
    
    // MARK: - Buttons
    
    static func filledButton() -> UIButton {
        return RoundedButton(cornerRadius: 5, borderWidth: 0,
                             backgroundColor: ThemeColors.maroon,
                             borderColor: .clear, tintColor: .white)
    }
    
    static func hollowButton() -> UIButton {
        return RoundedButton(cornerRadius: 5, borderWidth: 1,
                             backgroundColor: .clear,
                             borderColor: .white, tintColor: .white)
    }
    
    // MARK: - Text
    
    static func textView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textView.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
        textView.textColor = .white
        textView.tintColor = ThemeColors.maroon
        
        return textView
    }
    
    // MARK: - Navigation Bar
    
    static func doneStyleBarButton(title: String?, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(title: title, style: .done, target: target, action: action)
        barButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
        
        return barButton
    }
    
}
