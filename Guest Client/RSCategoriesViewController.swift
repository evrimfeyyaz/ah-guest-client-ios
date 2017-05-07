//
//  RSCategoriesViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCategoriesViewController: UITableViewController {
    
    // MARK: - Public properties
    
    var dataTask: URLSessionDataTask?
    
    // MARK: - Private properties
    
    private let defaultSession = URLSession(configuration: .default)
    
    private let categoryCellIdentifier = "category"
    
    private var rsCategories: [RSCategory]? = nil
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    // MARK: - View configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRSCategories()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureActivityIndicator()
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    private func configureTableView() {
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(RSCategoryTableViewCell.self, forCellReuseIdentifier: categoryCellIdentifier)
    }
    
    private func configureNavigationBar() {
        let ordersBarButton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(ordersBarButtonTapped))
        let cartBarButton = ThemeViewFactory.doneStyleBarButton(title: "Cart", target: self, action: #selector(cartBarButtonTapped))
        
        navigationItem.title = "Room Service"
        navigationItem.leftBarButtonItem = ordersBarButton
        navigationItem.rightBarButtonItem = cartBarButton
        
        let backButton = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Actions
    
    @objc private func ordersBarButtonTapped() {
        print("Go to orders")
    }
    
    @objc private func cartBarButtonTapped() {
        print("Go to cart")
    }
    
    // MARK: - Private instance methods
    
    private func fetchRSCategories() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicatorView.startAnimating()
        
        RSCategory.all() { rsCategories in
            self.rsCategories = rsCategories
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.activityIndicatorView.stopAnimating()
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier) as! RSCategoryTableViewCell
        let rsCategory = rsCategories![indexPath.row]
        
        categoryCell.categoryTitleLabel.text = rsCategory.title
        categoryCell.categoryDescriptionLabel.text = rsCategory.description
        categoryCell.categoryImageURL = rsCategory.imageURL
            
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rsCategories?.count ?? 0
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCell = tableView.cellForRow(at: indexPath) as! RSCategoryTableViewCell
        
        let rsItemsVC = RSItemsViewController(style: .grouped)
        rsItemsVC.navigationItem.title = categoryCell.categoryTitleLabel.text
        
        show(rsItemsVC, sender: self)
    }

}
