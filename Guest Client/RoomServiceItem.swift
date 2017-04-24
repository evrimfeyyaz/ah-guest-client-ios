//
//  RoomServiceItem.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItem {
    
    private var _longDescription: String?
    
    let id: Int
    let title: String
    let shortDescription: String?
    var longDescription: String? {
        get {
            if let longDescription = _longDescription {
                return longDescription
            } else {
                return shortDescription
            }
        }
        
        set {
            _longDescription = newValue
        }
    }
    let price: Decimal
    let image: UIImage?
    let attributes: [RoomServiceItemAttribute]
    let options: [RoomServiceItemOption]
    let sectionId: Int
    
    init(id: Int, title: String, shortDescription: String? = nil,
         longDescription: String? = nil, price: Decimal, image: UIImage? = nil,
         attributes: [RoomServiceItemAttribute], options: [RoomServiceItemOption],
         sectionId: Int) {
        self.id = id
        self.title = title
        self.shortDescription = shortDescription
        self.price = price
        self.image = image
        self.attributes = attributes
        self.options = options
        self.sectionId = sectionId
        self.longDescription = longDescription
    }
    
    static func getItem(itemId id: Int) -> RoomServiceItem? {
        let porkAttribute = RoomServiceItemAttribute(id: 0, title: "Pork", rgbColorInHex: "EB6277", icon: UIImage())
        let alcoholAttribute = RoomServiceItemAttribute(id: 1, title: "Alcohol", rgbColorInHex: "DEDEDE", icon: UIImage())
        
        let choice1 = RoomServiceItemOptionChoice(id: 0, title: "Regular")
        let choice2 = RoomServiceItemOptionChoice(id: 1, title: "Large", price: 0.200)
        
        let options = RoomServiceItemOption(id: 0, title: "Size", isOptional: false,
                                                    allowsMultipleChoices: false, choices: [choice1, choice2],
                                                    defaultChoice: choice1)
        
        return RoomServiceItem(id: 0, title: "Starbucks Table-Side French Press",
                               shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                               longDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas laoreet quis lacus sed vestibulum. Sed auctor auctor ex eu ullamcorper.",
                               price: 6.000,
                               image: nil,
                               attributes: [porkAttribute, alcoholAttribute],
                               options: [options], sectionId: 0)
    }
    
}
