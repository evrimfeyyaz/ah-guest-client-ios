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
        return RoundedButton(cornerRadius: 5, borderThickness: 0,
                             backgroundColor: ThemeColors.maroon,
                             borderColor: .clear, textColor: .white)
    }
    
    static func hollowButton() -> UIButton {
        return RoundedButton(cornerRadius: 5, borderThickness: 2,
                             backgroundColor: .clear,
                             borderColor: .white, textColor: .white)
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
