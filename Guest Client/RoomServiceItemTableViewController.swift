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
    
    private let multipleChoicePreferenceCellIdentifier = "multipleChoicePreferenceCellIdentifier"
    private let singleChoicePreferenceCellIdentifier = "singleChoicePreferenceCellIdentifier"
    
    // MARK: - Public properties
    
    var item: RoomServiceItem

    // MARK: - Initializers
    
    init(roomServiceItem: RoomServiceItem) {
        self.item = roomServiceItem
        
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
        tableView.register(RoomServiceItemMultipleChoicePreferenceTableViewCell.self,
                           forCellReuseIdentifier: multipleChoicePreferenceCellIdentifier)
        tableView.register(RoomServiceItemSingleChoicePreferenceTableViewCell.self,
                           forCellReuseIdentifier: singleChoicePreferenceCellIdentifier)
        
        // Set up the table header view.
        let itemDetailView = RoomServiceItemDetailView()
        itemDetailView.itemTitleLabel.text = item.title
        itemDetailView.itemDescriptionLabel.text = item.longDescription
        itemDetailView.itemPriceLabel.text = item.price.stringInDefaultCurrency
        
        for attribute in item.attributes {
            let attributeView = AttributeView(title: attribute.title)
            
            itemDetailView.itemAttributesView.addArrangedSubview(attributeView)
        }
        
        tableView.tableHeaderView = itemDetailView
        tableView.layoutTableHeaderView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let preference = item.preferences[indexPath.row]
        
        let cell: RoomServiceItemPreferenceTableViewCell
        if preference.allowsMultipleChoices {
            cell = tableView.dequeueReusableCell(withIdentifier: multipleChoicePreferenceCellIdentifier) as! RoomServiceItemMultipleChoicePreferenceTableViewCell
            
        } else {
            let singleChoiceCell = tableView.dequeueReusableCell(withIdentifier: singleChoicePreferenceCellIdentifier) as! RoomServiceItemSingleChoicePreferenceTableViewCell
            
            if let defaultChoiceId = preference.defaultChoiceId {
                let defaultChoiceTitle = preference.choices.first(where: { $0.id == defaultChoiceId })?.title
                singleChoiceCell.choiceLabel.text = defaultChoiceTitle
            }
            
            cell = singleChoiceCell
        }
        
        cell.titleLabel.text = preference.title
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.preferences.count
    }
    
    // MARK: - Table view delegate
    
}
















