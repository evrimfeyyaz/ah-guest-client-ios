//
//  RSItemPreference.swift
//  Guest Client
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
    let possibleChoices: [RSItemOptionChoice]
    let defaultChoice: RSItemOptionChoice?
    
    // MARK: - Initializers
    
    init(id: Int, title: String, isOptional: Bool, allowsMultipleChoices: Bool,
         possibleChoices: [RSItemOptionChoice], defaultChoice: RSItemOptionChoice? = nil) {
        
        self.id = id
        self.title = title
        self.isOptional = isOptional
        self.allowsMultipleChoices = allowsMultipleChoices
        self.possibleChoices = possibleChoices
        self.defaultChoice = defaultChoice
    }
    
    // MARK: - Equatable
    
    static func == (lhs: RSItemOption, rhs: RSItemOption) -> Bool {
        return lhs.id == rhs.id
    }
    
}
