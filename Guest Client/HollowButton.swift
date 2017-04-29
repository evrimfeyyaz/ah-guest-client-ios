//
//  HollowButton.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/28/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class HollowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title?.uppercased(), for: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        titleLabel?.font = ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.oswaldRegular, withSize: 17)
        titleLabel?.textColor = .white
    }

}
