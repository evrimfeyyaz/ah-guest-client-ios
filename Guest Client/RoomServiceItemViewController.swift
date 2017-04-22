//
//  RoomServiceItemViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private let itemTitleLabel = StyledLabel(withStyle: .titleOne)
    private let itemAttributesView = UIStackView()
    private let itemPriceLabel = StyledLabel(withStyle: .price)
    private let itemDescriptionLabel = StyledLabel(withStyle: .body)
    private let itemChoicesTableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    private let choiceBooleanCellIdentifier = "choiceBooleanCellIdentifier"
    
    // MARK: - Public properties
    
    var itemTitle: String {
        get { return itemTitleLabel.text ?? "" }
        set { itemTitleLabel.text = newValue }
    }
    
    var itemPrice: String {
        get { return itemPriceLabel.text ?? "" }
        set { itemPriceLabel.text = newValue }
    }
    
    var itemDescription: String? {
        get { return itemDescriptionLabel.text }
        set { itemDescriptionLabel.text = newValue }
    }
    
    let itemId: Int
    var item: RoomServiceItem?

    // MARK: - Initializers
    
    init(itemId: Int) {
        self.itemId = itemId
        
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
        
        // Set up the item title label.
        view.addSubview(itemTitleLabel)
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15)
            ])
        
        // Set up the item attributes view.
        view.addSubview(itemAttributesView)
        itemAttributesView.translatesAutoresizingMaskIntoConstraints = false
        itemAttributesView.alignment = .center
        itemAttributesView.distribution = .equalSpacing
        itemAttributesView.spacing = 10
        NSLayoutConstraint.activate([
            itemAttributesView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            itemAttributesView.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 2)
            ])
        
        // Set up the item price label.
        view.addSubview(itemPriceLabel)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            itemPriceLabel.centerYAnchor.constraint(equalTo: itemAttributesView.centerYAnchor),
            itemPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: itemAttributesView.trailingAnchor, constant: 15)
            ])
        
        // Set up the item description label.
        view.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.numberOfLines = 0
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemAttributesView.bottomAnchor, constant: 6)
            ])
        
        // Set up the item choices table view.
        itemChoicesTableView.dataSource = self
        itemChoicesTableView.delegate = self
        itemChoicesTableView.register(ChoiceBooleanTableViewCell.self, forCellReuseIdentifier: choiceBooleanCellIdentifier)
        itemChoicesTableView.rowHeight = 100
        view.addSubview(itemChoicesTableView)
        itemChoicesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemChoicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemChoicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemChoicesTableView.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor),
//            itemChoicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            itemChoicesTableView.heightAnchor.constraint(equalToConstant: itemChoicesTableView.rowHeight * CGFloat(itemChoicesTableView.numberOfRows(inSection: 0)))
            ])
        itemChoicesTableView.reloadData()
        
        if let item = RoomServiceItem.getItem(itemId: itemId) {
            itemTitle = item.title
            
            for attribute in item.attributes {
                let attributeView = AttributeView()
                attributeView.title = attribute.title
                
                itemAttributesView.addArrangedSubview(attributeView)
            }
            
            itemPrice = item.price.stringInDefaultCurrency!
            if let longDescription = item.longDescription, !longDescription.isEmpty {
                itemDescription = longDescription
            } else if let shortDescription = item.shortDescription, !shortDescription.isEmpty {
                itemDescription = shortDescription
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choiceCell = tableView.dequeueReusableCell(withIdentifier: choiceBooleanCellIdentifier) as! ChoiceBooleanTableViewCell
        choiceCell.titleLabel.text = "Test"
        print("hello")
        
        return choiceCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: - Table view delegate
    
}






















