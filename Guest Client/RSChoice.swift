//
//  RSItemPreferenceChoice.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import SwiftyJSON

class RSChoice: Equatable {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let price: Decimal
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        
        let priceString = json["price"].stringValue
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        self.price = price
    }

    
    // MARK: - Equatable
    
    static func == (lhs: RSChoice, rhs: RSChoice) -> Bool {
        return lhs.id == rhs.id
    }
    
}
