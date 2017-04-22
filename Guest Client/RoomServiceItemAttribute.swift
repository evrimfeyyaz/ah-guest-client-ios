//
//  RoomServiceItemAttribute.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemAttribute {
    
    let id: Int
    let title: String
    let rgbColorInHex: String
    let icon: UIImage
    
    init(id: Int, title: String, rgbColorInHex: String, icon: UIImage) {
        self.id = id
        self.title = title
        self.rgbColorInHex = rgbColorInHex
        self.icon = icon
    }
    
}
