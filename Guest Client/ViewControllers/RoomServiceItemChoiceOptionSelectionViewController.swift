//
//  Created by Evrim Persembe on 4/23/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemChoiceOptionSelectionViewController: UITableViewController {
    
    // MARK: - Public properties
    var cartItemViewController: RoomServiceCartItemViewController?
    
    // MARK: - Private properties
    private let itemChoice: RoomServiceItemChoice
    private let cartItem: RoomServiceCartItem
    
    private let tableViewCellIdentifier = "tableViewCell"
    private let tableViewHeaderIdentifier = "tableViewHeader"
    
    // MARK: - Initializers
    init(itemChoice: RoomServiceItemChoice, cartItem: RoomServiceCartItem) {
        self.itemChoice = itemChoice
        self.cartItem = cartItem
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderIdentifier)
        
        if (itemChoice.allowsMultipleOptions) {
            tableView.allowsMultipleSelection = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        cartItemViewController?.optionChanged()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemChoice.options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! TableViewCell
        let option = itemChoice.options[indexPath.row]
        
        cell.titleLabel.text = option.title
        
        if option.price > 0 {
            cell.detailLabel.text = option.price.stringInBahrainiDinars
        }
        
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        if cartItem.selectedOptionIDs.contains(option.id) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderIdentifier) as! TableViewHeader
        
        var headerTitle = itemChoice.title
        if (itemChoice.isOptional) {
            headerTitle += " (optional)"
        }
        
        headerView.titleLabel.text = headerTitle
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = itemChoice.options[indexPath.row]
        
        cartItem.addSelectedOption(withID: option.id)
        
        if (itemChoice.allowsMultipleOptions) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if (itemChoice.allowsMultipleOptions) {
            let option = itemChoice.options[indexPath.row]
            cartItem.removeSelectedOption(withID: option.id)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
