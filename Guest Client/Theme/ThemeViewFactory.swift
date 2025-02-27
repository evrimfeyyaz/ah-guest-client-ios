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
    
    static func navigationBarButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = ThemeFonts.latoRegular.withSize(17)
        button.titleLabel?.textAlignment = .right
        
        return button
    }
    
    // MARK: - Text
    
    static func textView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textView.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 15)
        textView.textColor = .white
        textView.tintColor = ThemeColors.maroon
        
        return textView
    }
    
    static func textField() -> UITextField {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textField.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 15)
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        
        textField.tintColor = ThemeColors.maroon
        
        return textField
    }
    
    // MARK: - Date
    
    static func datePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.sendAction(Selector(("setHighlightsToday:")), to: nil, for: nil)
        
        return datePicker
    }
    
    // MARK: - Navigation Bar
    
    static func doneStyleBarButton(title: String?, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(title: title, style: .done, target: target, action: action)
        barButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
        
        return barButton
    }
    
}
