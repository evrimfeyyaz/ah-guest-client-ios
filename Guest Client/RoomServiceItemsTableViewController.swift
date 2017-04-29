//
//  RoomServiceItemsTableViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let roomServiceItemSections: [RoomServiceItemSection] = {
        RoomServiceItemSection.getAll()
    }()
    
    // MARK: - Private properties
    private let itemCellIdentifier = "itemCellIdentifier"
    private let headerViewIdentifier = "headerViewIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - View setup
    
    func configureView() {
        // Set up the table view.
        tableView.backgroundView = nil
        tableView.backgroundColor = ThemeImages.backgroundImage
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(RoomServiceItemTableViewCell.self, forCellReuseIdentifier: itemCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
        
        let cartBarButton = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(goToCart))
        cartBarButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
        
        navigationItem.rightBarButtonItem = cartBarButton
    }
    
    @objc private func goToCart() {
        print("Go to cart")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return roomServiceItemSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomServiceItemSections[section].numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier,
                                                     for: indexPath) as! RoomServiceItemTableViewCell

        let section = indexPath.section
        let row = indexPath.row
        let item = roomServiceItemSections[section].items[row]
        
        itemCell.itemTitle = item.title
        itemCell.itemDescription = item.shortDescription
        itemCell.itemPrice = item.price.stringInDefaultCurrency ?? ""
        itemCell.itemId = item.id
        itemCell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        itemCell.selectionStyle = .none

        return itemCell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as! TableViewHeader
        headerView.title = roomServiceItemSections[section].title
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
        let item = roomServiceItemSections[indexPath.section].items[indexPath.row]
        let itemVC = RoomServiceItemTableViewController(roomServiceItem: item)
        let navigationVC = UINavigationController(rootViewController: itemVC)
        
        present(navigationVC, animated: true, completion: nil)
    }

}
