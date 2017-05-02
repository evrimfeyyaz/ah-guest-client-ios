//
//  RSCartItem.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSCartItem {
    
    // MARK: - Public properties
    
    var id: Int?
    let rsItem: RSItem
    var quantity: Int
    var choicesForOptions: [RSItemChoicesForOption]
    var specialRequest: String?
    
    var totalPrice: Decimal {
        get {
            let totalPriceForOneItem = choicesForOptions.flatMap({ choicesForOption in
                choicesForOption.selectedChoices
            }).reduce(rsItem.price, { sum, choice in
                sum + choice.price
            })
            
            return totalPriceForOneItem * Decimal(quantity)
        }
    }
    
    // MARK: - Initializers
    
    init(id: Int? = nil, rsItem: RSItem, quantity: Int = 1,
         choices: [RSItemChoicesForOption] = [],
         specialRequest: String? = nil) {
        
        self.rsItem = rsItem
        self.quantity = quantity
        self.choicesForOptions = choices
        self.specialRequest = specialRequest
        
        for option in rsItem.options {
            if (option.allowsMultipleChoices) {
                self.choicesForOptions.append(RSItemChoicesForMultipleChoiceOption(option: option))
            } else {
                self.choicesForOptions.append(RSItemChoicesForSingleChoiceOption(option: option))
            }
        }
    }
    
    // MARK: - Public instance methods
    
    func choices(for option: RSItemOption) -> RSItemChoicesForOption? {
        if let index = choicesForOptions.index(where: { $0.option == option }) {
            return choicesForOptions[index]
        }
        
        return nil
    }
    
    func choicesAndOptionsAsString() -> String {
        return choicesForOptions.map({ "\($0.option.title): \($0.selectedChoicesAsString())" }).joined(separator: "\n")
    }
    
}
