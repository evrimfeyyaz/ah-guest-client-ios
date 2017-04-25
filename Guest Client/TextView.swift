//
//  TextView.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/25/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class TextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.08)
        
        font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 17)
        textColor = ThemeColors.white
        tintColor = ThemeColors.maroon
    }

}
