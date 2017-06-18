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
    var specialRequest: String?
    private(set) var selectedOptionIDs: [Int]
    
    var selectedOptions: [RoomServiceItemChoiceOption] {
        get {
            let possibleOptions = item.choices.flatMap { $0.options }
            
            return selectedOptionIDs.flatMap { optionID in
                return possibleOptions.first { $0.id == optionID }
            }
        }
    }
    
    var totalPrice: Decimal {
        get {
            let totalPriceForOneItem = selectedOptions.reduce(item.price) { $0 + $1.price }
            return totalPriceForOneItem * Decimal(quantity)
        }
    }
    
    var selectedOptionsAsString: String {
        return selectedOptions.flatMap { $0.title }.joined(separator: ", ")
    }
    
    // MARK: - Initializers
    init(id: Int? = nil, item: RoomServiceItem, quantity: Int = 1,
         selectedOptionIDs: [Int] = [], specialRequest: String? = nil) {
        
        self.id = id
        self.item = item
        self.quantity = quantity
        self.specialRequest = specialRequest
        self.selectedOptionIDs = selectedOptionIDs
    }
    
    // MARK: - Public instance methods
    func options(for choice: RoomServiceItemChoice) -> [RoomServiceItemChoiceOption] {
        return item.choices.first { $0.id == choice.id }?.options ?? []
    }
    
    func addSelectedOption(withID id: Int) {
        guard let choiceOptionBelongsTo = item.choices.first(where: { $0.options.contains { $0.id == id } }) else { return }
        
        if !choiceOptionBelongsTo.allowsMultipleOptions {
            let indexesOfSelectedOptionsFromChoice = choiceOptionBelongsTo.options.flatMap { selectedOptionIDs.index(of: $0.id) }
            
            for optionIndex in indexesOfSelectedOptionsFromChoice {
                selectedOptionIDs.remove(at: optionIndex)
            }
        }
        
        selectedOptionIDs.append(id)
    }
    
    func selectedOptionsAsString(for choice: RoomServiceItemChoice) -> String {
        return choice.options.filter { selectedOptionIDs.contains($0.id) }.map { $0.title }.joined(separator: ", ")
    }
    
    func removeSelectedOption(withID id: Int) {
        guard let optionIndex = selectedOptionIDs.index(of: id) else { return }
        
        selectedOptionIDs.remove(at: optionIndex)
    }
    
    func toJSON() -> [String: Any] {
        return [
            "quantity": quantity,
            "special_request": specialRequest ?? "",
            "room_service_item_id": item.id,
            "selected_option_ids": selectedOptionIDs
        ]
    }
}







