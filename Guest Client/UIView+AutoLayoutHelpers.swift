//
//  ViewHelpers.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

extension UIView {
    
    func alhAnchor(toTopAnchor topAnchor: NSLayoutYAxisAnchor,
                   toRightAnchor rightAnchor: NSLayoutXAxisAnchor,
                   toBottomAnchor bottomAnchor: NSLayoutYAxisAnchor,
                   toLeftAnchor leftAnchor: NSLayoutXAxisAnchor) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor),
            self.rightAnchor.constraint(equalTo: rightAnchor),
            self.bottomAnchor.constraint(equalTo: bottomAnchor),
            self.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
    
    func alhCenter(toView view: UIView,
                   withXOffset xOffset: CGFloat = 0,
                   withYOffset yOffset: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset)
            ])
    }
    
}
