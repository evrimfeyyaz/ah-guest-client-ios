//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import SwiftyJSON

class RSTag {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
    }
    
}
