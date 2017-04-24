//
//  RoomServiceItemPreference.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/21/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceItemOption {
    
    let id: Int
    let title: String
    let isOptional: Bool
    let allowsMultipleChoices: Bool
    let choices: [RoomServiceItemOptionChoice]
    let defaultChoiceId: Int?
    
    init(id: Int, title: String, isOptional: Bool, allowsMultipleChoices: Bool,
         choices: [RoomServiceItemOptionChoice], defaultChoiceId: Int? = nil) {
        self.id = id
        self.title = title
        self.isOptional = isOptional
        self.allowsMultipleChoices = allowsMultipleChoices
        self.choices = choices
        self.defaultChoiceId = defaultChoiceId
    }
    
}
