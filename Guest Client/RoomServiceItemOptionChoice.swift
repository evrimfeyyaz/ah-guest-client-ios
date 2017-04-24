//
//  RoomServiceItemPreferenceChoice.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceItemOptionChoice {
    
    let id: Int
    let title: String
    let price: Decimal
    
    init(id: Int, title: String, price: Decimal = 0) {
        self.id = id
        self.title = title
        self.price = price
    }
    
}
