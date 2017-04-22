//
//  RoomServiceItemViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private let choiceBooleanCellIdentifier = "choiceBooleanCellIdentifier"
    
    // MARK: - Public properties
    
    var item: RoomServiceItem

    // MARK: - Initializers
    
    init(roomServiceItem: RoomServiceItem) {
        self.item = roomServiceItem
        
        super.init(nibName: nil, bundle: nil)
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
        tableView.separatorStyle = .none
        
        // Set up the table header view.
        let itemDetailView = RoomServiceItemDetailView()
        itemDetailView.itemTitleLabel.text = item.title
        itemDetailView.itemDescriptionLabel.text = item.longDescription
        itemDetailView.itemPriceLabel.text = item.price.stringInDefaultCurrency
        
        for attribute in item.attributes {
            let attributeView = AttributeView()
            attributeView.title = attribute.title
            
            itemDetailView.itemAttributesView.addArrangedSubview(attributeView)
        }
        tableView.tableHeaderView = itemDetailView
        
        
        // Set up the item choices table view.
//        itemChoicesTableView.dataSource = self
//        itemChoicesTableView.delegate = self
//        itemChoicesTableView.register(ChoiceBooleanTableViewCell.self, forCellReuseIdentifier: choiceBooleanCellIdentifier)
//        itemChoicesTableView.rowHeight = 100
//        view.addSubview(itemChoicesTableView)
//        itemChoicesTableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            itemChoicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            itemChoicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            itemChoicesTableView.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor),
////            itemChoicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            itemChoicesTableView.heightAnchor.constraint(equalToConstant: itemChoicesTableView.rowHeight * CGFloat(itemChoicesTableView.numberOfRows(inSection: 0)))
//            ])
//        itemChoicesTableView.reloadData()
//        
//        if let item = RoomServiceItem.getItem(itemId: itemId) {
//            itemTitle = item.title
//            
//            for attribute in item.attributes {
//                let attributeView = AttributeView()
//                attributeView.title = attribute.title
//                
//                itemAttributesView.addArrangedSubview(attributeView)
//            }
//            
//            itemPrice = item.price.stringInDefaultCurrency!
//            if let longDescription = item.longDescription, !longDescription.isEmpty {
//                itemDescription = longDescription
//            } else if let shortDescription = item.shortDescription, !shortDescription.isEmpty {
//                itemDescription = shortDescription
//            }
//            
//        }
    }
    
    // MARK: - Table view data source
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let choiceCell = tableView.dequeueReusableCell(withIdentifier: choiceBooleanCellIdentifier) as! ChoiceBooleanTableViewCell
//        choiceCell.titleLabel.text = "Test"
//        print("hello")
//        
//        return choiceCell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
    
    // MARK: - Table view delegate
    
}






















