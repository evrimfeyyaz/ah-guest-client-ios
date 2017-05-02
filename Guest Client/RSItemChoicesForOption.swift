//
//  RSItemChoicesForOption.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSItemChoicesForOption: Equatable {
    
    // MARK: - Public properties
    
    let option: RSItemOption
    
    var numberOfPossibleChoices: Int {
        get { return option.possibleChoices.count }
    }
    
    // MARK: - Private properties
    
    fileprivate(set) public var selectedChoices: [RSItemOptionChoice] = []
    
    // MARK: - Initializers
    
    init(option: RSItemOption) {
        self.option = option
        
        if let defaultChoice = option.defaultChoice {
            selectedChoices.append(defaultChoice)
        }
    }
    
    // MARK: - Equatable
    
    static func == (lhs: RSItemChoicesForOption, rhs: RSItemChoicesForOption) -> Bool {
        return lhs.option == rhs.option
    }
    
    // MARK: - Public instance methods
    
    func isChoiceSelected(_ choice: RSItemOptionChoice) -> Bool {
        return selectedChoices.contains(choice)
    }
    
    func selectedChoicesAsString() -> String {
        return selectedChoices.map({ $0.title }).joined(separator: " / ")
    }
    
}

class RSItemChoicesForMultipleChoiceOption: RSItemChoicesForOption {
    
    // MARK: - Public instance methods
    
    func addSelectedChoice(_ choice: RSItemOptionChoice) {
        if (selectedChoices.contains(choice)) {
            return
        }
        
        selectedChoices.append(choice)
    }
    
    func removeSelectedChoice(_ choice: RSItemOptionChoice) {
        if let index = selectedChoices.index(of: choice) {
            selectedChoices.remove(at: index)
        }
    }
    
}

class RSItemChoicesForSingleChoiceOption: RSItemChoicesForOption {
    
    // MARK: - Public instance methods
    
    func makeSelectedChoice(choice: RSItemOptionChoice) {
        selectedChoices.removeAll()
        selectedChoices.append(choice)
    }
    
}
