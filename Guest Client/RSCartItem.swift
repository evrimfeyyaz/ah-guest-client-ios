//
//  RSCartItem.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSCartItem {
    
    var id: Int?
    let rsItem: RSItem
    var quantity: Int
    var choices: [RSItemChoicesForOption]
    var specialRequest: String?
    
    var totalPrice: Decimal {
        get {
            let totalPriceForOneItem = choices.flatMap({ choicesForOption in
                choicesForOption.selectedChoices
            }).reduce(rsItem.price, { sum, choice in
                sum + choice.price
            })
            
            return totalPriceForOneItem * Decimal(quantity)
        }
    }
    
    init(id: Int? = nil, rsItem: RSItem, quantity: Int = 1,
         choices: [RSItemChoicesForOption] = [],
         specialRequest: String? = nil) {
        self.rsItem = rsItem
        self.quantity = quantity
        self.choices = choices
        self.specialRequest = specialRequest
        
        for option in rsItem.options {
            if (option.allowsMultipleChoices) {
                self.choices.append(RSItemChoicesForMultipleChoiceOption(option: option))
            } else {
                self.choices.append(RSItemChoicesForSingleChoiceOption(option: option))
            }
        }
    }
    
    func choices(for option: RSItemOption) -> RSItemChoicesForOption? {
        if let index = choices.index(where: { $0.option == option }) {
            return choices[index]
        }
        
        return nil
    }
    
}
