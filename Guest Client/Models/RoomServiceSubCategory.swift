//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceSubCategory {
    // MARK: - Public static properties
    let id: Int
    let title: String
    private(set) var items: [RoomServiceItem]
    
    var isDefault: Bool {
        get { return title == "__default" }
    }
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let itemsJSONArray = json["items"] as? [[String: Any]]
            else { return nil }
        
        self.id = id
        self.title = title
        self.items = itemsJSONArray.flatMap { RoomServiceItem(json: $0) }.sorted { $0.0.id < $0.1.id }
    }
}
