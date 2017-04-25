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
    
    // MARK: - Private properties
    let categoryCellIdentifier = "categoryCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the table view.
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(RoomServiceCategoryTableViewCell.self, forCellReuseIdentifier: categoryCellIdentifier)
        
        // Set up the navigation bar.
        let infoBarButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showOnboarding))
//        let ordersBarButton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(showOrders))
        
        navigationItem.title = "Room Service"
        navigationItem.leftBarButtonItem = infoBarButton
        
        let backButton = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc private func showOnboarding() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier) as! RoomServiceCategoryTableViewCell
        let roomServiceCategory = roomServiceCategories[indexPath.row]
        
        categoryCell.categoryTitle = roomServiceCategory.title
        categoryCell.categoryDescription = roomServiceCategory.description
        categoryCell.categoryImage = roomServiceCategory.image
            
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomServiceCategories.count
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCell = tableView.cellForRow(at: indexPath) as! RoomServiceCategoryTableViewCell
        
        let roomServiceItemsTableVC = RoomServiceItemsTableViewController()
        roomServiceItemsTableVC.navigationItem.title = categoryCell.categoryTitle
        
        show(roomServiceItemsTableVC, sender: self)
    }

}
