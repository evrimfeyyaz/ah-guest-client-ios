//
//  NavigationButton.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

@IBDesignable class NavigationButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        styleView()
    }
    
    override func prepareForInterfaceBuilder() {
        styleView()
    }
    
    func styleView() {
        self.titleLabel?.font = Theme.navigationButtonFont
        self.setTitleColor(Theme.navigationButtonTextColorNormalState, for: UIControlState.normal)
    }
    
}
