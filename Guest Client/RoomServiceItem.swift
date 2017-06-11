//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItem {
    // MARK: - Public properties
    let id: Int
    let title: String
    let shortDescription: String?
    var longDescription: String?
    let price: Decimal
    var tags: [RoomServiceTag] = []
    var options: [RoomServiceOption] = []
    
    // MARK: - Initializers
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let priceString = json["price"] as? String
            else { return nil }
        
        self.id = id
        self.title = title
        self.shortDescription = json["short_description"] as? String
        self.longDescription = json["long_description"] as? String
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        
        self.price = price
        
        if let tagsJSONArray = json["tags"] as? [[String: Any]] {
            self.tags = tagsJSONArray.flatMap { RoomServiceTag(json: $0) }
        }
        
        if let optionsJSONArray = json["options"] as? [[String: Any]] {
            self.options = optionsJSONArray.flatMap { RoomServiceOption(json: $0) }
        }
    }
}









