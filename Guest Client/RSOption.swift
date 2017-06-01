//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import SwiftyJSON

class RSOption: Equatable {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let isOptional: Bool
    let allowsMultipleChoices: Bool
    var possibleChoices: [RSChoice] = []
    var defaultChoiceID: Int?
    
    var defaultChoice: RSChoice? {
        get {
            guard let defaultChoiceID = self.defaultChoiceID else { return nil }
            
            return possibleChoices.first(where: { $0.id == defaultChoiceID })
        }
    }
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.isOptional = json["optional"].boolValue
        self.allowsMultipleChoices = json["allows_multiple_choices"].boolValue
        self.defaultChoiceID = json["default_room_service_choice_id"].intValue
        
        let possibleChoicesJSON = json["possible_choices"].arrayValue
        for possibleChoiceJSON in possibleChoicesJSON {
            if let choice = RSChoice(json: possibleChoiceJSON) {
                self.possibleChoices.append(choice)
            }
        }
    }

    
    // MARK: - Equatable
    
    static func == (lhs: RSOption, rhs: RSOption) -> Bool {
        return lhs.id == rhs.id
    }
    
}
