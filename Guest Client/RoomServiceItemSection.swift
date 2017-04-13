//
//  RoomServiceItemSection.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

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
        if (self.id == 1) {
            return [
                RoomServiceItem(title: "Starbucks Table-Side French Press", description: nil, price: 6.000, image: nil),
                RoomServiceItem(title: "Freshly Brewed Coffee", description: nil, price: 7.250, image: nil),
                RoomServiceItem(title: "Selection of Hot Teas", description: "Espresso, lattes and cappuccionos are also available.", price: 7.250, image: nil)
            ]
        } else {
            return [
                RoomServiceItem(title: "Breakfast Smoothies", description: "Yogurt, honey and fruit puree", price: 5.250, image: nil),
                RoomServiceItem(title: "Seasonal Fruits and Berries", description: nil, price: 9.000, image: #imageLiteral(resourceName: "breakfast"))
            ]
        }
    }
    
}
