//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItemAttribute {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    
    // MARK: - Initializers
    
    init?(jsonData: [String: Any], jsonIncluded: [[String: Any]]? = nil) {
        guard
            let idString = jsonData["id"] as? String,
            let attributes = jsonData["attributes"] as? [String: Any],
            let title = attributes["title"] as? String
            else { return nil }
        
        self.id = Int(idString)!
        self.title = title
    }

    
}
