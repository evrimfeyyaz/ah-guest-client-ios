//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceItemChoiceOption: Equatable {
    // MARK: - Public properties
    let id: Int
    let title: String
    let price: Decimal
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let priceString = json["price"] as? String
            else { return nil }
        
        self.id = id
        self.title = title
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        self.price = price
    }
    
    // MARK: - Equatable
    static func == (lhs: RoomServiceItemChoiceOption, rhs: RoomServiceItemChoiceOption) -> Bool {
        return lhs.id == rhs.id
    }
}
