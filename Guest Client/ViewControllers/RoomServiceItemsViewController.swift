//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemsViewController: UITableViewController {
    // MARK: - Public properties
    var categoryID: Int?
    
    // MARK: - Private properties
    private let itemCellIdentifier = "item"
    private let tableViewHeaderViewIdentifier = "tableViewHeader"
    private var subCategories: [RoomServiceSubCategory] = []
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private var orderBarButton: UIBarButtonItem!
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRoomServiceSubCategoriesAndItemSummaries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toggleOrderButton()
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    private func configureView() {
        configureActivityIndicator()
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        let button = ThemeViewFactory.navigationBarButton()
        button.setTitle("Order", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(cartBarButtonTapped), for: .touchUpInside)
        
        orderBarButton = UIBarButtonItem(customView: button)
    }
    
    private func configureTableView() {
        tableView.backgroundView = nil
        tableView.backgroundColor = ThemeImages.backgroundImage
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(RSItemTableViewCell.self, forCellReuseIdentifier: itemCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderViewIdentifier)
    }
    
    // MARK: - Actions
    @objc private func cartBarButtonTapped() {
        let cartVC = RoomServiceOrderViewController(style: .grouped)
        let navigationVC = UINavigationController(rootViewController: cartVC)
        
        show(navigationVC, sender: self)
    }
    
    // MARK: - Private instance methods
    private func fetchRoomServiceSubCategoriesAndItemSummaries() {
        activityIndicatorView.startAnimating()
        
        APIManager.shared.indexRoomServiceSubCategories(categoryID: categoryID!) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success(let subCategories):
                self.subCategories = subCategories.sorted { $0.0.id < $0.1.id }
                self.tableView.reloadData()
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet {
                    let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
                        self?.fetchRoomServiceSubCategoriesAndItemSummaries()
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return subCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier,
                                                     for: indexPath) as! RSItemTableViewCell

        let section = indexPath.section
        let row = indexPath.row
        let item = subCategories[section].items[row]
        
        itemCell.itemTitleLabel.text = item.title
        // TODO: Change this to a conditional later that decides between short and long descriptions.
        itemCell.itemDescriptionLabel.text = item.shortDescription ?? item.description
        itemCell.itemPriceLabel.text = item.price.stringInBahrainiDinars ?? ""
        // TODO: Find a way to set this globally.
        itemCell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        itemCell.selectionStyle = .none
        
        return itemCell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if subCategories[section].isDefault { return nil }
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderViewIdentifier) as! TableViewHeader
        headerView.titleLabel.text = subCategories[section].title
        // TODO: Find a way to set this globally.
        headerView.contentView.backgroundColor = .clear
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 35
        } else {
            return 25
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = subCategories[indexPath.section].items[indexPath.row]
        let itemDetailVC = RoomServiceCartItemViewController(roomServiceItemID: item.id)
        let navigationVC = UINavigationController(rootViewController: itemDetailVC)
        
        present(navigationVC, animated: true, completion: nil)
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
