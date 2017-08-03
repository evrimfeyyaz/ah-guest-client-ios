//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire
import UIBarButtonItem_Badge_Coding

class RoomServiceCategoriesViewController: UITableViewController {
    
    // MARK: - Private properties
    private let categoryCellIdentifier = "category"
    private var categories = [RoomServiceCategory]()
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private var orderBarButton: UIBarButtonItem!
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRoomServiceCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toggleOrderButton()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        let button = ThemeViewFactory.navigationBarButton()
        button.setTitle("Order", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(cartBarButtonTapped), for: .touchUpInside)
        
        orderBarButton = UIBarButtonItem(customView: button)
        
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
        navigationItem.title = "Room Service"
        
        let backButton = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc private func cartBarButtonTapped() {
        let cartVC = RoomServiceOrderViewController(style: .grouped)
        let navigationVC = UINavigationController(rootViewController: cartVC)
        
        show(navigationVC, sender: self)
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
                                                        message: "Items in \"\(category.title)\" are only available from \(availableFromInLocalTime) until \(availableUntilInLocalTime).", preferredStyle: .alert)
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
    
    private func toggleOrderButton() {
        let order = RoomServiceOrder.cart
        let quantityOfAllItems = order.cartItems.reduce(0) { $0.0 + $0.1.quantity }
        
        if quantityOfAllItems > 0 {
            navigationItem.rightBarButtonItem = orderBarButton
            orderBarButton.badgeValue = "\(quantityOfAllItems)"
            orderBarButton.badgeBGColor = ThemeColors.orange
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}
