//
//  RoomServiceItemViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private let tableViewCellIdentifier = "tableViewCellIdentifier"
    
    // MARK: - Public properties
    
    let cartItem: RoomServiceCartItem

    // MARK: - Initializers
    
    init(roomServiceItem: RoomServiceItem) {
        self.cartItem = RoomServiceCartItem(roomServiceItem: roomServiceItem)
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
    }

    func setUpViews() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the table view.
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = ThemeColors.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: tableViewCellIdentifier)
        
        // Set up the table header view.
        let itemDetailView = RoomServiceItemDetailView()
        itemDetailView.itemTitleLabel.text = cartItem.roomServiceItem.title
        itemDetailView.itemDescriptionLabel.text = cartItem.roomServiceItem.longDescription
        itemDetailView.itemPriceLabel.text = cartItem.roomServiceItem.price.stringInDefaultCurrency
        
        for attribute in cartItem.roomServiceItem.attributes {
            let attributeView = AttributeView(title: attribute.title)
            
            itemDetailView.itemAttributesView.addArrangedSubview(attributeView)
        }
        
        tableView.tableHeaderView = itemDetailView
        tableView.layoutTableHeaderView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choicesForOption = cartItem.choices[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! TableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.titleLabel.text = choicesForOption.option.title
        
        if !choicesForOption.option.allowsMultipleChoices {
            cell.detailLabel.text = choicesForOption.selectedChoices.first?.title
        }
        
        cell.titleLabel.text = choicesForOption.option.title
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItem.roomServiceItem.options.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = cartItem.roomServiceItem.options[indexPath.row]
        
        let optionVC: RoomServiceItemOptionChoicesTableViewController
        if let choicesForOption = cartItem.choices(for: option) {
            optionVC = RoomServiceItemOptionChoicesTableViewController(choicesForOption: choicesForOption)
        } else {
            optionVC = RoomServiceItemOptionChoicesTableViewController(choicesForOption: RoomServiceItemChoicesForOption(option: option))
        }
        
        show(optionVC, sender: self)
    }
    
}
















