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
    private var sections: [RoomServiceSection] = []
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicator()
        configureView()
        fetchRoomServiceSectionsAndItemSummaries()
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    private func configureView() {
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureTableView() {
        tableView.backgroundView = nil
        tableView.backgroundColor = ThemeImages.backgroundImage
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(RSItemTableViewCell.self, forCellReuseIdentifier: itemCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderViewIdentifier)
    }
    
    private func configureNavigationBar() {
        // TODO: This is used in RSCategoriesViewController as well. Find a way to refactor this.
        let cartBarButton = ThemeViewFactory.doneStyleBarButton(title: "Cart", target: self, action: #selector(cartBarButtonTapped))
        
        navigationItem.rightBarButtonItem = cartBarButton
    }
    
    // MARK: - Actions
    @objc private func cartBarButtonTapped() {
        let cartVC = RoomServiceOrderViewController(style: .grouped)
        let navigationVC = UINavigationController(rootViewController: cartVC)
        
        show(navigationVC, sender: self)
    }
    
    // MARK: - Private instance methods
    private func fetchRoomServiceSectionsAndItemSummaries() {
        activityIndicatorView.startAnimating()
        
        APIManager.shared.indexRoomServiceCategorySections(categoryID: categoryID!) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success(let sections):
                self.sections = sections
                self.tableView.reloadData()
            case .failure(let error):
                let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier,
                                                     for: indexPath) as! RSItemTableViewCell

        let section = indexPath.section
        let row = indexPath.row
        let item = sections[section].items[row]
        
//        itemCell.itemTitleLabel.text = item.title
        itemCell.itemTitleLabel.text = "Lorem ipsum dolor sit amet here is a long text let's see how long this can go without getting cut off let's make it very long here to see."
        // TODO: Change this to a conditional later that decides between short and long descriptions.
//        itemCell.itemDescriptionLabel.text = item.longDescription?.capitalizingFirstLetter()
        itemCell.itemDescriptionLabel.text = "Lorem ipsum dolor sit amet here is a long text let's see how long this can go without getting cut off let's make it very long here to see."
        itemCell.itemPriceLabel.text = item.price.stringInBahrainiDinars ?? ""
        // TODO: Find a way to set this globally.
        itemCell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        itemCell.selectionStyle = .none
        
        return itemCell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section].isDefault { return nil }
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderViewIdentifier) as! TableViewHeader
        headerView.titleLabel.text = sections[section].title
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
        let item = sections[indexPath.section].items[indexPath.row]
        let itemDetailVC = RoomServiceCartItemViewController(roomServiceItemID: item.id)
        let navigationVC = UINavigationController(rootViewController: itemDetailVC)
        
        present(navigationVC, animated: true, completion: nil)
    }

}
