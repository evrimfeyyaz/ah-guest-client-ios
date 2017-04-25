//
//  RoomServiceCartItem.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceCartItem {
    
    var id: Int?
    let roomServiceItem: RoomServiceItem
    var quantity: Int
    var choices: [RoomServiceItemChoicesForOption]
    var specialRequest: String?
    
    var totalPrice: Decimal {
        get {
            let totalPriceForOneItem = choices.flatMap({ choicesForOption in
                choicesForOption.selectedChoices
            }).reduce(roomServiceItem.price, { sum, choice in
                sum + choice.price
            })
            
            return totalPriceForOneItem * Decimal(quantity)
        }
    }
    
    init(id: Int? = nil, roomServiceItem: RoomServiceItem, quantity: Int = 1,
         choices: [RoomServiceItemChoicesForOption] = [],
         specialRequest: String? = nil) {
        self.roomServiceItem = roomServiceItem
        self.quantity = quantity
        self.choices = choices
        self.specialRequest = specialRequest
        
        for option in roomServiceItem.options {
            if (option.allowsMultipleChoices) {
                self.choices.append(RoomServiceItemChoicesForMultipleChoiceOption(option: option))
            } else {
                self.choices.append(RoomServiceItemChoicesForSingleChoiceOption(option: option))
            }
        }
    }
    
    func choices(for option: RoomServiceItemOption) -> RoomServiceItemChoicesForOption? {
        if let index = choices.index(where: { $0.option == option }) {
            return choices[index]
        }
        
        return nil
    }
    
}
