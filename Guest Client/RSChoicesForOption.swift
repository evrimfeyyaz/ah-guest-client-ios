//
//  RSChoicesForOption.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSChoicesForOption: Equatable {
    
    // MARK: - Public properties
    
    let option: RSOption
    
    var numberOfPossibleChoices: Int {
        get { return option.possibleChoices.count }
    }
    
    // MARK: - Private properties
    
    fileprivate(set) public var selectedChoices: [RSChoice] = []
    
    // MARK: - Initializers
    
    init(option: RSOption) {
        self.option = option
        
        if let defaultChoice = option.defaultChoice {
            selectedChoices.append(defaultChoice)
        }
    }
    
    // MARK: - Equatable
    
    static func == (lhs: RSChoicesForOption, rhs: RSChoicesForOption) -> Bool {
        return lhs.option == rhs.option
    }
    
    // MARK: - Public instance methods
    
    func isChoiceSelected(_ choice: RSChoice) -> Bool {
        return selectedChoices.contains(choice)
    }
    
    func selectedChoicesAsString() -> String {
        return selectedChoices.map({ $0.title }).joined(separator: " / ")
    }
    
}

class RSItemChoicesForMultipleChoiceOption: RSChoicesForOption {
    
    // MARK: - Public instance methods
    
    func addSelectedChoice(_ choice: RSChoice) {
        if (selectedChoices.contains(choice)) {
            return
        }
        
        selectedChoices.append(choice)
    }
    
    func removeSelectedChoice(_ choice: RSChoice) {
        if let index = selectedChoices.index(of: choice) {
            selectedChoices.remove(at: index)
        }
    }
    
}

class RSItemChoicesForSingleChoiceOption: RSChoicesForOption {
    
    // MARK: - Public instance methods
    
    func makeSelectedChoice(choice: RSChoice) {
        selectedChoices.removeAll()
        selectedChoices.append(choice)
    }
    
}
