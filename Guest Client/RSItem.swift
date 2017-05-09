//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItem {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let shortDescription: String?
    var longDescription: String? {
        get {
            if let longDescription = _longDescription {
                return longDescription
            } else {
                return shortDescription
            }
        }
        
        set {
            _longDescription = newValue
        }
    }
    let price: Decimal
    var attributes: [RSItemAttribute] = []
    var options: [RSItemOption] = []
    
    // MARK: - Private properties
    
    private var _longDescription: String?
    
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
        self.shortDescription = attributes["short-description"] as? String
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        self.price = price
    }

    
    static func getItem(itemId id: Int) -> RSItem? {
        return nil
    }
    
}
