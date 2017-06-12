//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceOption: Equatable {
    // MARK: - Public properties
    let id: Int
    let title: String
    let isOptional: Bool
    let allowsMultipleChoices: Bool
    var possibleChoices = [RoomServiceChoice]()
    var defaultRoomServiceChoiceID: Int?
    
    var defaultChoice: RoomServiceChoice? {
        get {
            guard let defaultRoomServiceChoiceID = self.defaultRoomServiceChoiceID else { return nil }
            
            return possibleChoices.first(where: { $0.id == defaultRoomServiceChoiceID })
        }
    }
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let isOptional = json["optional"] as? Bool,
            let allowsMultipleChoices = json["allows_multiple_choices"] as? Bool,
            let possibleChoicesJSONArray = json["possible_choices"] as? [[String: Any]]
            else { return nil }
        
        self.id = id
        self.title = title
        self.isOptional = isOptional
        self.allowsMultipleChoices = allowsMultipleChoices
        self.defaultRoomServiceChoiceID = json["default_room_service_choice_id"] as? Int
        self.possibleChoices = possibleChoicesJSONArray.flatMap { RoomServiceChoice.init(json: $0) }
    }

    
    // MARK: - Equatable
    static func == (lhs: RoomServiceOption, rhs: RoomServiceOption) -> Bool {
        return lhs.id == rhs.id
    }
}
