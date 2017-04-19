//
//  RoomServiceCategoryImageView.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCategoryImageView: UIImageView {
    
    let gradient = CAGradientLayer()
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        setUpViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpViews()
    }
    
    func setUpViews() {
        gradient.colors = [UIColor.black.withAlphaComponent(0.85).cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        
        layer.insertSublayer(gradient, at: 0)
    }

    override func layoutSubviews() {
        // To fix issues with Auto Layout.
        gradient.frame = self.bounds
    }

}
