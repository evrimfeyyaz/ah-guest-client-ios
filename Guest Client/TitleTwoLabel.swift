//
//  TitleTwoLabel.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

@IBDesignable class TitleTwoLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        styleView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForInterfaceBuilder() {
        styleView()
    }
    
    func styleView() {
        self.font = Theme.titleTwoFont
        self.textColor = Theme.titleTwoTextColor
    }
    
}
