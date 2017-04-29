//
//  CustomViewFactory.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/29/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ThemeViewFactory {
    
    static func textView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textView.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
        textView.textColor = .white
        textView.tintColor = ThemeColors.maroon
        
        return textView
    }
    
}
