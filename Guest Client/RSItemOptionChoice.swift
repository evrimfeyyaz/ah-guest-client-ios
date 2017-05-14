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
    
    init?(jsonData: [String: Any], jsonIncluded: [[String: Any]]? = nil) {
        guard
            let idString = jsonData["id"] as? String,
            let attributes = jsonData["attributes"] as? [String: Any],
            let title = attributes["title"] as? String,
            let priceString = attributes["price"] as? String
            else { return nil }
        
        self.id = Int(idString)!
        self.title = title
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        self.price = price
    }

    
    // MARK: - Equatable
    
    static func == (lhs: RSItemOptionChoice, rhs: RSItemOptionChoice) -> Bool {
        return lhs.id == rhs.id
    }
    
}
