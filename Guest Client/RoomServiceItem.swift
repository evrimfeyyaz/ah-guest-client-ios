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
    let id: Int
    let attributes: [String]?
    
    init(title: String, description: String?, price: Decimal, image: UIImage?, attributes: [String]?) {
        self.title = title
        self.description = description
        self.price = price
        self.image = image
        self.attributes = attributes ?? []
        
        self.id = 0
    }
    
    static func getItem(itemId id: Int) -> RoomServiceItem {
        return RoomServiceItem(title: "Starbucks Table-Side French Press",
                               description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas laoreet quis lacus sed vestibulum. Sed auctor auctor ex eu ullamcorper.",
                               price: 6.000,
                               image: nil,
                               attributes: ["Pork", "Alcholic"])
    }
    
}
