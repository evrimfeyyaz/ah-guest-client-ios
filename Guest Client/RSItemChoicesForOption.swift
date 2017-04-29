//
//  RSItemChoicesForOption.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSItemChoicesForOption: Equatable {
    
    let option: RSItemOption
    
    fileprivate(set) public var selectedChoices: [RSItemOptionChoice] = []
    
    var numberOfPossibleChoices: Int {
        get { return option.choices.count }
    }
    
    init(option: RSItemOption) {
        self.option = option
        
        if let defaultChoice = option.defaultChoice {
            selectedChoices.append(defaultChoice)
        }
    }
    
    static func == (lhs: RSItemChoicesForOption, rhs: RSItemChoicesForOption) -> Bool {
        return lhs.option == rhs.option
    }
    
    func isSelected(choice: RSItemOptionChoice) -> Bool {
        return selectedChoices.contains(choice)
    }
    
    func selectedChoicesAsString() -> String {
        return selectedChoices.map({ $0.title }).joined(separator: " / ")
    }
    
}

class RSItemChoicesForMultipleChoiceOption: RSItemChoicesForOption {
    
    func addSelectedChoice(choice: RSItemOptionChoice) {
        if (selectedChoices.contains(choice)) {
            return
        }
        
        selectedChoices.append(choice)
    }
    
    func removeSelectedChoice(choice: RSItemOptionChoice) {
        if let index = selectedChoices.index(of: choice) {
            selectedChoices.remove(at: index)
        }
    }
    
}

class RSItemChoicesForSingleChoiceOption: RSItemChoicesForOption {
    
    func makeSelectedChoice(choice: RSItemOptionChoice) {
        selectedChoices.removeAll()
        selectedChoices.append(choice)
    }
    
}
