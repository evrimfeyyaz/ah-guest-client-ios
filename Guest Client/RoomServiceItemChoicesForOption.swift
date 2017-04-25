//
//  RoomServiceItemChoicesForOption.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceItemChoicesForOption: Equatable {
    
    let option: RoomServiceItemOption
    
    fileprivate(set) public var selectedChoices: [RoomServiceItemOptionChoice] = []
    
    var numberOfPossibleChoices: Int {
        get { return option.choices.count }
    }
    
    init(option: RoomServiceItemOption) {
        self.option = option
        
        if let defaultChoice = option.defaultChoice {
            selectedChoices.append(defaultChoice)
        }
    }
    
    static func == (lhs: RoomServiceItemChoicesForOption, rhs: RoomServiceItemChoicesForOption) -> Bool {
        return lhs.option == rhs.option
    }
    
    func isSelected(choice: RoomServiceItemOptionChoice) -> Bool {
        return selectedChoices.contains(choice)
    }
    
    func selectedChoicesAsString() -> String {
        return selectedChoices.map({ $0.title }).joined(separator: " / ")
    }
    
}

class RoomServiceItemChoicesForMultipleChoiceOption: RoomServiceItemChoicesForOption {
    
    func addSelectedChoice(choice: RoomServiceItemOptionChoice) {
        if (selectedChoices.contains(choice)) {
            return
        }
        
        selectedChoices.append(choice)
    }
    
    func removeSelectedChoice(choice: RoomServiceItemOptionChoice) {
        if let index = selectedChoices.index(of: choice) {
            selectedChoices.remove(at: index)
        }
    }
    
}

class RoomServiceItemChoicesForSingleChoiceOption: RoomServiceItemChoicesForOption {
    
    func makeSelectedChoice(choice: RoomServiceItemOptionChoice) {
        selectedChoices.removeAll()
        selectedChoices.append(choice)
    }
    
}
