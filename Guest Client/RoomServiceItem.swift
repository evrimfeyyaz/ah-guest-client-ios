//
//  RoomServiceItem.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItem {
    
    let title: String
    let description: String?
    let price: Decimal
    let image: UIImage?
    
    init(title: String, description: String?, price: Decimal, image: UIImage?) {
        self.title = title
        self.description = description
        self.price = price
        self.image = image
    }
    
}
