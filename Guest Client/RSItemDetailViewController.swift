//
//  RSItemViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItemDetailViewController: UITableViewController, UITextViewDelegate {
    
    // MARK: - Private properties
    
    private let tableViewCellIdentifier = "tableViewCellIdentifier"
    private let textEntryTableViewCellIdentifier = "textEntryTableViewCellIdentifier"
    private let quantityTableViewCellIdentifier = "quantityTableViewCellIdentifier"
    private let itemDetailView = RSItemDetailView()
    private let footerView = RSCartItemFooterView()
    
    // MARK: - Public properties
    
    let cartItem: RSCartItem

    // MARK: - Initializers
    
    init(rsItem: RSItem) {
        self.cartItem = RSCartItem(rsItem: rsItem)
        
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

    private func setUpViews() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the navigation items.
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAddItemAndDismiss))
        let addToCartButton = UIBarButtonItem(title: "Add to Cart", style: .done, target: self, action: #selector(addItemToCartAndDismiss))
        addToCartButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addToCartButton
        
        // Set up the table view.
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = ThemeColors.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(TextEntryTableViewCell.self,
                           forCellReuseIdentifier: textEntryTableViewCellIdentifier)
        tableView.register(QuantityTableViewCell.self,
                           forCellReuseIdentifier: quantityTableViewCellIdentifier)
        
        // Set up the table header view.
        itemDetailView.itemTitleLabel.text = cartItem.rsItem.title
        itemDetailView.itemDescriptionLabel.text = cartItem.rsItem.longDescription
        itemDetailView.itemPriceLabel.text = cartItem.rsItem.price.stringInDefaultCurrency
        
        for attribute in cartItem.rsItem.attributes {
            let attributeView = AttributeView(title: attribute.title)
            
            itemDetailView.itemAttributesView.addArrangedSubview(attributeView)
        }
        
        tableView.tableHeaderView = itemDetailView
        tableView.layoutTableHeaderView()
        
        footerView.totalPriceLabel.text = cartItem.totalPrice.stringInDefaultCurrency
        footerView.addToCartButton.addTarget(self, action: #selector(addItemToCartAndDismiss), for: .touchUpInside)
        tableView.tableFooterView = footerView
        tableView.layoutTableFooterView()
    }
    
    func reloadChangedRow() {
        tableView.reloadData()
        updatePriceInItemDetail()
    }
    
    func cancelAddItemAndDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemToCartAndDismiss() {
        RSCart.shared.add(item: cartItem)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let choicesForOption = cartItem.choices[indexPath.row]
        
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! TableViewCell
            cell.accessoryType = .disclosureIndicator
        
            var optionTitle = choicesForOption.option.title
            if choicesForOption.option.isOptional {
                optionTitle += " (optional)"
            }
            cell.titleLabel.text = optionTitle
        
            if choicesForOption.option.allowsMultipleChoices {
                cell.descriptionLabel.text = choicesForOption.selectedChoicesAsString()
            } else {
                cell.detailLabel.text = choicesForOption.selectedChoicesAsString()
            }
        
            cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: textEntryTableViewCellIdentifier) as! TextEntryTableViewCell
            
            cell.titleLabel.text = "Special request (optional)"
            cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
            cell.textView.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: quantityTableViewCellIdentifier) as! QuantityTableViewCell
            
            cell.quantityStepper.value = Double(cartItem.quantity)
            cell.quantityStepper.addTarget(self, action: #selector(quantityChanged(sender:)), for: .valueChanged)
            
            cell.titleLabel.text = "Quantity"
            cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
            
            return cell
        }
    }
    
    func quantityChanged(sender: UIStepper) {
        cartItem.quantity = Int(sender.value)
        
        updatePriceInItemDetail()
    }
    
    func updatePriceInItemDetail() {
        let priceString = cartItem.totalPrice.stringInDefaultCurrency
        itemDetailView.itemPriceLabel.text = priceString
        footerView.totalPriceLabel.text = priceString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cartItem.rsItem.options.count
        } else {
            return 1
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            return
        }
        
        let option = cartItem.rsItem.options[indexPath.row]
        
        let optionVC: RSItemOptionChoicesViewController
        if let choicesForOption = cartItem.choices(for: option) {
            optionVC = RSItemOptionChoicesViewController(choicesForOption: choicesForOption)
            optionVC.itemViewController = self
            show(optionVC, sender: nil)
        }
    }
    
    // MARK: - Text view delegate
    
    func textViewDidChange(_ textView: UITextView) {
        // From: http://candycode.io/self-sizing-uitextview-in-a-uitableview-using-auto-layout-like-reminders-app/
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
}
















