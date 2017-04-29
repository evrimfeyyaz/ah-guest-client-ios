//
//  RSCategoriesViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCategoriesViewController: UITableViewController {
    
    let rsCategories = RSCategory.getAll()
    
    // MARK: - Private properties
    let categoryCellIdentifier = "categoryCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the table view.
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(RSCategoryTableViewCell.self, forCellReuseIdentifier: categoryCellIdentifier)
        
        // Set up the navigation bar.
        let ordersBarButton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(goToOrders))
        
        let cartBarButton = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(goToCart))
        cartBarButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
        
        navigationItem.title = "Room Service"
        navigationItem.leftBarButtonItem = ordersBarButton
        navigationItem.rightBarButtonItem = cartBarButton
        
        let backButton = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc private func goToOrders() {
        print("Go to orders")
    }
    
    @objc private func goToCart() {
        print("Go to cart")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier) as! RSCategoryTableViewCell
        let rsCategory = rsCategories[indexPath.row]
        
        categoryCell.categoryTitle = rsCategory.title
        categoryCell.categoryDescription = rsCategory.description
        categoryCell.categoryImage = rsCategory.image
            
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rsCategories.count
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCell = tableView.cellForRow(at: indexPath) as! RSCategoryTableViewCell
        
        let rsItemsTableVC = RSItemsViewController()
        rsItemsTableVC.navigationItem.title = categoryCell.categoryTitle
        
        show(rsItemsTableVC, sender: self)
    }

}
