//
//  RoomServiceCategoryStore.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCategory {
    let title: String
    let description: String?
    let image: UIImage?
    
    init(title: String, description: String?, image: UIImage?) {
        self.title = title
        self.description = description
        self.image = image
    }
    
    static func getAll() -> [RoomServiceCategory] {
        return [
            RoomServiceCategory(title: "Breakfastg", description: "served from 6am to 11am", image: #imageLiteral(resourceName: "breakfast")),
            RoomServiceCategory(title: "All Day Dining", description: "served from 11am to 12am", image: #imageLiteral(resourceName: "breakfast")),
            RoomServiceCategory(title: "Wine", description: nil, image: nil)
        ]
    }
}
