//
//  ClearNavigationBar.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class ClearNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        styleView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleView()
    }
    
    func styleView() {
        backgroundColor = .clear
        isTranslucent = true
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }
    
}
