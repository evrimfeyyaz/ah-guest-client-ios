//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSItemOption: Equatable {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let isOptional: Bool
    let allowsMultipleChoices: Bool
    var possibleChoices: [RSItemOptionChoice]
    var defaultChoiceID: Int?
    
    var defaultChoice: RSItemOptionChoice? {
        get {
            guard let defaultChoiceID = self.defaultChoiceID else { return nil }
            
            return possibleChoices.first(where: { $0.id == defaultChoiceID })
        }
    }
    
    // MARK: - Initializers
    
    init?(jsonData: [String: Any], jsonIncluded: [[String: Any]]? = nil) {
        guard
            let idString = jsonData["id"] as? String,
            let attributes = jsonData["attributes"] as? [String: Any],
            let title = attributes["title"] as? String,
            let isOptional = attributes["optional"] as? Bool,
            let allowsMultipleChoices = attributes["allows-multiple-choices"] as? Bool
            else { return nil }
        
        self.id = Int(idString)!
        self.title = title
        self.isOptional = isOptional
        self.allowsMultipleChoices = allowsMultipleChoices
        
        if let defaultChoiceIDString = attributes["default-choice-id"] as? String {
            self.defaultChoiceID = Int(defaultChoiceIDString)!
        }
        
        self.possibleChoices = []
        if let relationships = jsonData["relationships"] as? [String: Any],
            let choiceReferencesJSON = relationships["possible-choices"] as? [String: Any],
            let choicesDataJSON = choiceReferencesJSON["data"] as? [[String: Any]] {
            
            if let jsonIncluded = jsonIncluded {
                for choiceDataJSON in choicesDataJSON {
                    if let choiceIDString = choiceDataJSON["id"] as? String {
                        let choiceJSON = jsonIncluded.first(where: {
                            if let includedID = $0["id"] as? String,
                                let includedType = $0["type"] as? String {
                                return includedID == choiceIDString &&
                                    includedType == "room-service-item-option-choices"
                            }
                            
                            return false
                        })
                        
                        if let choiceJSON = choiceJSON,
                            let choice = RSItemOptionChoice(jsonData: choiceJSON) {
                            self.possibleChoices.append(choice)
                        }
                    }
                }
            }
        }
    }

    
    // MARK: - Equatable
    
    static func == (lhs: RSItemOption, rhs: RSItemOption) -> Bool {
        return lhs.id == rhs.id
    }
    
}
