//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceCartItem {
    // MARK: - Public properties
    var id: Int?
    var item: RoomServiceItem
    var quantity: Int
    var choicesForOptions: [RoomServiceChoicesForOption]
    var specialRequest: String?
    
    var totalPrice: Decimal {
        get {
            let totalPriceForOneItem = choicesForOptions.flatMap({ choicesForOption in
                choicesForOption.selectedChoices
            }).reduce(item.price, { sum, choice in
                sum + choice.price
            })
            
            return totalPriceForOneItem * Decimal(quantity)
        }
    }
    
    // MARK: - Initializers
    init(id: Int? = nil, item: RoomServiceItem, quantity: Int = 1,
         choices: [RoomServiceChoicesForOption] = [],
         specialRequest: String? = nil) {
        
        self.item = item
        self.quantity = quantity
        self.choicesForOptions = choices
        self.specialRequest = specialRequest
        
        for option in item.options {
            if (option.allowsMultipleChoices) {
                self.choicesForOptions.append(RSItemChoicesForMultipleChoiceOption(option: option))
            } else {
                self.choicesForOptions.append(RSItemChoicesForSingleChoiceOption(option: option))
            }
        }
    }
    
    // MARK: - Public instance methods
    func choices(for option: RoomServiceOption) -> RoomServiceChoicesForOption? {
        if let index = choicesForOptions.index(where: { $0.option == option }) {
            return choicesForOptions[index]
        }
        
        return nil
    }
    
    func choicesAndOptionsAsString() -> String {
        return choicesForOptions
            .filter({ $0.selectedChoices.count > 0 })
            .map({ "\($0.option.title): \($0.selectedChoicesAsString())" })
            .joined(separator: "\n")
    }
    
    func toJSON() -> [String: Any] {
        let choicesForOptionsAttributes = choicesForOptions.enumerated().reduce([String: Any]()) {
            result, indexedChoicesForOption in
            
            var mutableResult = result
            mutableResult["\(indexedChoicesForOption.offset)"] = indexedChoicesForOption.element.toJSON()
            
            return mutableResult
        }
        
        return [
            "quantity": quantity,
            "special_request": specialRequest,
            "room_service_item_id": item.id,
            "choices_for_options_attributes": choicesForOptionsAttributes
        ]
    }
}







