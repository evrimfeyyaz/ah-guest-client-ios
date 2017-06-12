//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCategory {
    // MARK: - Public properties
    let id: Int
    let title: String
    let description: String?
    var imageURL: URL?
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let imageURLs = json["image_urls"] as? [String: String?]
            else { return nil }
        
        self.id = id
        self.title = title
        self.description = json["description"] as? String
        
        if UIScreen.main.scale == 1.0, let oneXImageURLString = imageURLs["@1x"] as? String {
            self.imageURL = URL(string: oneXImageURLString)
        } else if UIScreen.main.scale == 2.0, let twoXImageURLString = imageURLs["@2x"] as? String {
            self.imageURL = URL(string: twoXImageURLString)
        } else if let threeXImageURLString = imageURLs["@3x"] as? String {
            self.imageURL = URL(string: threeXImageURLString)
        }
    }
}









