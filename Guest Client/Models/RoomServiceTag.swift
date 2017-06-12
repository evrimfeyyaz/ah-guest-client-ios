//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceTag {
    // MARK: - Public properties
    let id: Int
    let title: String
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String
            else { return nil }
        
        self.id = id
        self.title = title
    }
}
