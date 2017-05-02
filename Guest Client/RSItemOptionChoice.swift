//
//  RSItemPreferenceChoice.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSItemOptionChoice: Equatable {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let price: Decimal
    
    // MARK: - Initializers
    
    init(id: Int, title: String, price: Decimal = 0) {
        self.id = id
        self.title = title
        self.price = price
    }
    
    // MARK: - Equatable
    
    static func == (lhs: RSItemOptionChoice, rhs: RSItemOptionChoice) -> Bool {
        return lhs.id == rhs.id
    }
    
}
