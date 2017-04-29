//
//  CustomViewFactory.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/29/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeViewFactory {
    
    static func filledButton() -> UIButton {
        return RoundedButton(cornerRadius: 5, borderWidth: 0,
                             backgroundColor: ThemeColors.maroon,
                             borderColor: .clear, tintColor: .white)
    }
    
    static func hollowButton() -> UIButton {
        return RoundedButton(cornerRadius: 5, borderWidth: 2,
                             backgroundColor: .clear,
                             borderColor: .white, tintColor: .white)
    }
    
    static func textView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textView.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
        textView.textColor = .white
        textView.tintColor = ThemeColors.maroon
        
        return textView
    }
    
}
