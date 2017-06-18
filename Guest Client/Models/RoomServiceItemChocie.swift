//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceItemChoice: Equatable {
    // MARK: - Public properties
    let id: Int
    let title: String
    let isOptional: Bool
    let allowsMultipleOptions: Bool
    var options = [RoomServiceItemChoiceOption]()
    var defaultOptionID: Int?
    
    var defaultOption: RoomServiceItemChoiceOption? {
        get {
            guard let defaultOptionID = self.defaultOptionID else { return nil }
            
            return options.first(where: { $0.id == defaultOptionID })
        }
    }
    
    // MARK: - Initializers
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let isOptional = json["optional"] as? Bool,
            let allowsMultipleOptions = json["allows_multiple_options"] as? Bool,
            let optionsJSONArray = json["options"] as? [[String: Any]]
            else { return nil }
        
        self.id = id
        self.title = title
        self.isOptional = isOptional
        self.allowsMultipleOptions = allowsMultipleOptions
        self.defaultOptionID = json["default_option_id"] as? Int
        self.options = optionsJSONArray.flatMap { RoomServiceItemChoiceOption.init(json: $0) }
    }
    
    
    // MARK: - Equatable
    static func == (lhs: RoomServiceItemChoice, rhs: RoomServiceItemChoice) -> Bool {
        return lhs.id == rhs.id
    }
}
