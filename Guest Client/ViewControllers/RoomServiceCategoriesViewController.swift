//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class RoomServiceCategoriesViewController: UITableViewController {
    
    // MARK: - Private properties
    private let categoryCellIdentifier = "category"
    private var categories = [RoomServiceCategory]()
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRoomServiceCategories()
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
        //        let ordersBarButton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(ordersBarButtonTapped))
        let cartBarButton = ThemeViewFactory.doneStyleBarButton(title: "Order", target: self, action: #selector(cartBarButtonTapped))
        
        navigationItem.title = "Room Service"
        //        navigationItem.leftBarButtonItem = ordersBarButton
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
    private func fetchRoomServiceCategories() {
        activityIndicatorView.startAnimating()
        
        APIManager.shared.loadCurrentUserFromStoredAuthentication { _ in }
        
        APIManager.shared.indexRoomServiceCategories { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success(let categories):
                self.categories = categories.sorted { $0.0.id < $0.1.id }
                self.tableView.reloadData()
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet {
                    let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
                        self?.fetchRoomServiceCategories()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                    
                    break
                }
                
                let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier) as! RSCategoryTableViewCell
        let rsCategory = categories[indexPath.row]
        
        categoryCell.categoryTitleLabel.text = rsCategory.title
        categoryCell.categoryDescriptionLabel.text = rsCategory.description
        categoryCell.categoryImageURL = rsCategory.imageURL
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCell = tableView.cellForRow(at: indexPath) as! RSCategoryTableViewCell
        
        let category = categories[indexPath.row]
        
        let localTimeZone = TimeZone(identifier: "Asia/Riyadh")!
        guard category.isCurrentlyAvailable else {
            
            let availableFromInLocalTime = category.availableFromUTC!.description(inTimeZone: localTimeZone)
            let availableUntilInLocalTime = category.availableUntilUTC!.description(inTimeZone: localTimeZone)
            
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Not Available",
                                                        message: "\(category.title) is only available from \(availableFromInLocalTime) until \(availableUntilInLocalTime) in local time.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            return
        }
        
        let rsItemsVC = RoomServiceItemsViewController(style: .grouped)
        rsItemsVC.categoryID = category.id
        rsItemsVC.navigationItem.title = categoryCell.categoryTitleLabel.text
        
        show(rsItemsVC, sender: self)
    }
}
