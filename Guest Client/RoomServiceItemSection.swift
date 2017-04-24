//
//  RoomServiceItemSection.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemSection {

    let id: Int
    let title: String
    var numberOfItems: Int {
        get {
            if (self.id == 1) {
                return 3
            } else {
                return 2
            }
        }
    }
    
    lazy var items: [RoomServiceItem] = self.getAllItems()
    
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    static func getAll() -> [RoomServiceItemSection] {
        return [
            RoomServiceItemSection(id: 1, title: "Awaken Your Senses"),
            RoomServiceItemSection(id: 2, title: "Fruits, Cereals and Smoothies")
        ]
    }
    
    private func getAllItems() -> [RoomServiceItem] {
        let porkAttribute = RoomServiceItemAttribute(id: 0, title: "Pork", rgbColorInHex: "EB6277", icon: UIImage())
        let alcoholAttribute = RoomServiceItemAttribute(id: 1, title: "Alcohol", rgbColorInHex: "DEDEDE", icon: UIImage())
        
        let choice1 = RoomServiceItemOptionChoice(id: 0, title: "Regular")
        let choice2 = RoomServiceItemOptionChoice(id: 1, title: "Large", price: 0.200)
        
        let multipleChoice1 = RoomServiceItemOptionChoice(id: 0, title: "Extra cheese")
        let multipleChoice2 = RoomServiceItemOptionChoice(id: 1, title: "Extra pickles", price: 0.200)
        
        let option1 = RoomServiceItemOption(id: 0, title: "Size", isOptional: false,
                                                    allowsMultipleChoices: false, choices: [choice1, choice2],
                                                    defaultChoice: choice1)
        let option2 = RoomServiceItemOption(id: 1, title: "Extra items", isOptional: true, allowsMultipleChoices: true,
                                            choices: [multipleChoice1, multipleChoice2])
        
        if (self.id == 1) {
            return [
                RoomServiceItem(id: 0, title: "Starbucks Table-Side French Press",
                                shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                longDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas laoreet quis lacus sed vestibulum. Sed auctor auctor ex eu ullamcorper.",
                                price: 6.000,
                                image: nil,
                                attributes: [porkAttribute, alcoholAttribute],
                                options: [option1, option2], sectionId: 0),
                RoomServiceItem(id: 1, title: "Freshly Brewed Coffee", price: 7.250,
                                image: nil, attributes: [], options: [], sectionId: 0),
                RoomServiceItem(id: 2, title: "Selection of Hot Teas",
                                shortDescription: "Espresso, lattes and cappuccionos are also available.",
                                price: 7.250, image: nil, attributes: [], options: [], sectionId: 0)
            ]
        } else {
            return [
                RoomServiceItem(id: 3, title: "Breakfast Smoothies",
                                shortDescription: "Yogurt, honey and fruit puree",
                                price: 5.250, image: nil, attributes: [], options: [], sectionId: 0),
                RoomServiceItem(id: 4, title: "Seasonal Fruits and Berries", price: 9.000,
                                image: #imageLiteral(resourceName: "breakfast"), attributes: [], options: [], sectionId: 0)
            ]
        }
    }
    
}
