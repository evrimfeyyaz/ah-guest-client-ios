//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceChoicesForOption: Equatable {
    
    // MARK: - Public properties
    
    let option: RoomServiceOption
    
    var numberOfPossibleChoices: Int {
        get { return option.possibleChoices.count }
    }
    
    // MARK: - Private properties
    
    fileprivate(set) public var selectedChoices: [RoomServiceChoice] = []
    
    // MARK: - Initializers
    
    init(option: RoomServiceOption) {
        self.option = option
        
        if let defaultChoice = option.defaultChoice {
            selectedChoices.append(defaultChoice)
        }
    }
    
    // MARK: - Equatable
    
    static func == (lhs: RoomServiceChoicesForOption, rhs: RoomServiceChoicesForOption) -> Bool {
        return lhs.option == rhs.option
    }
    
    // MARK: - Public instance methods
    
    func isChoiceSelected(_ choice: RoomServiceChoice) -> Bool {
        return selectedChoices.contains(choice)
    }
    
    func selectedChoicesAsString() -> String {
        return selectedChoices.map({ $0.title }).joined(separator: " / ")
    }
    
}

class RSItemChoicesForMultipleChoiceOption: RoomServiceChoicesForOption {
    
    // MARK: - Public instance methods
    
    func addSelectedChoice(_ choice: RoomServiceChoice) {
        if (selectedChoices.contains(choice)) {
            return
        }
        
        selectedChoices.append(choice)
    }
    
    func removeSelectedChoice(_ choice: RoomServiceChoice) {
        if let index = selectedChoices.index(of: choice) {
            selectedChoices.remove(at: index)
        }
    }
    
}

class RSItemChoicesForSingleChoiceOption: RoomServiceChoicesForOption {
    
    // MARK: - Public instance methods
    
    func makeSelectedChoice(choice: RoomServiceChoice) {
        selectedChoices.removeAll()
        selectedChoices.append(choice)
    }
    
}
