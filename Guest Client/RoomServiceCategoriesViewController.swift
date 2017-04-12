//
//  RoomServiceCategoriesViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCategoriesViewController: UITableViewController {
    
    let roomServiceCategories = RoomServiceCategory.getAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomServiceCategory") as! RoomServiceCategoryTableViewCell
        let roomServiceCategory = roomServiceCategories[indexPath.row]
        
        cell.categoryTitle.text = roomServiceCategory.title
        cell.categoryDescription.text = roomServiceCategory.description
        cell.categoryImage.image = roomServiceCategory.image
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomServiceCategories.count
    }

}
