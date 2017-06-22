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
    var availableFromUTC: TimeUTC?
    var availableUntilUTC: TimeUTC?
    var imageURL: URL?
    
    var isCurrentlyAvailable: Bool {
        guard let availableFromUTC = availableFromUTC,
            let availableUntilUTC = availableUntilUTC
            else { return true }
        
        let currentTime = TimeUTC(date: Date())
        return currentTime.isBetween(startingTime: availableFromUTC, endingTime: availableUntilUTC)
    }
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let imageURLs = json["image_urls"] as? [String: String?]
            else { return nil }
        
        self.id = id
        self.title = title
        self.description = json["description"] as? String
        
        if let availableFromUTCString = json["available_from_utc"] as? String,
            let availableUntilUTCString = json["available_until_utc"] as? String {
            
            self.availableFromUTC = TimeUTC(hourColonMinute: availableFromUTCString)
            self.availableUntilUTC = TimeUTC(hourColonMinute: availableUntilUTCString)
        }
        
        if UIScreen.main.scale == 1.0, let oneXImageURLString = imageURLs["@1x"] as? String {
            self.imageURL = URL(string: oneXImageURLString)
        } else if UIScreen.main.scale == 2.0, let twoXImageURLString = imageURLs["@2x"] as? String {
            self.imageURL = URL(string: twoXImageURLString)
        } else if let threeXImageURLString = imageURLs["@3x"] as? String {
            self.imageURL = URL(string: threeXImageURLString)
        }
    }
}









