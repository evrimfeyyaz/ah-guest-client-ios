//
//  NavigationButton.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class NavigationButton: UIButton {

    dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
    
    dynamic var titleColorNormalState: UIColor! {
        get { return self.titleColor(for: .normal) }
        set { self.setTitleColor(newValue, for: .normal) }
    }
    
    dynamic var titleColorHighlightedState: UIColor! {
        get { return self.titleColor(for: .highlighted) }
        set { self.setTitleColor(newValue, for: .highlighted) }
    }
    
}
