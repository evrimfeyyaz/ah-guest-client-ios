//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class RSCartItemViewController: UITableViewController, UITextViewDelegate {
    
    // MARK: - Private properties
    
    private let itemDetailView = RSItemDetailView()
    private let footerView = RSCartItemFooterView()
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    private let tableViewCellIdentifier = "tableViewCell"
    private let textEntryTableViewCellIdentifier = "textEntry"
    private let quantityTableViewCellIdentifier = "quantity"
    
    private var cartItem: RSCartItem!
    private var rsItem: RSItem
    
    private let itemOptionsSectionIndex = 0
    private let specialRequestSectionIndex = 1
    private let quantitySectionIndex = 2

    // MARK: - Initializers
    
    init(rsItem: RSItem) {
        self.rsItem = rsItem
        
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
        
        configureActivityIndicator()
        configureNavigationBar()
        
        fetchRSItemDetails {
            self.cartItem = RSCartItem(rsItem: self.rsItem)
            
            self.configureTableView()
            self.configureItemDetailView()
            self.configureTableFooterView()
        }
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let addToCartButton = ThemeViewFactory.doneStyleBarButton(title: "Add to Cart", target: self, action: #selector(addToCartButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addToCartButton
    }
    
    private func configureTableView() {
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(TextEntryTableViewCell.self,
                           forCellReuseIdentifier: textEntryTableViewCellIdentifier)
        tableView.register(QuantityTableViewCell.self,
                           forCellReuseIdentifier: quantityTableViewCellIdentifier)
    }
    
    private func configureItemDetailView() {
        itemDetailView.itemTitleLabel.text = cartItem.rsItem.title
        itemDetailView.itemDescriptionLabel.text = cartItem.rsItem.longDescription?.capitalizingFirstLetter()
        itemDetailView.itemPriceLabel.text = cartItem.rsItem.price.stringInBahrainiDinars
        
        for attribute in cartItem.rsItem.itemAttributes {
            let attributeView = AttributeView(title: attribute.title)
            
            itemDetailView.itemAttributesStackView.addArrangedSubview(attributeView)
        }
        
        tableView.tableHeaderView = itemDetailView
        tableView.layoutTableHeaderOrFooterView(location: .header)
    }
    
    private func configureTableFooterView() {
        footerView.totalPriceLabel.text = cartItem.totalPrice.stringInBahrainiDinars
        footerView.addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        tableView.tableFooterView = footerView
        tableView.layoutTableHeaderOrFooterView(location: .footer)
    }
    
    // MARK: - Actions
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToCartButtonTapped() {
        RSCart.shared.add(item: cartItem)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func quantityStepperValueChanged(sender: UIStepper) {
        cartItem.quantity = Int(sender.value)
        
        updatePriceLabels()
    }
    
    // MARK: - Public instance methods
    
    func optionChanged() {
        tableView.reloadData()
        updatePriceLabels()
    }
    
    // MARK: - Private instance methods
    
    private func fetchRSItemDetails(completion: @escaping () -> Void) {
        activityIndicatorView.startAnimating()
        
        rsItem.fetchItemDetails {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                
                self.tableView.reloadData()
            }
            
            completion()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == itemOptionsSectionIndex {
            let choicesForOption = cartItem.choicesForOptions[indexPath.row]
            
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
        } else if indexPath.section == specialRequestSectionIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: textEntryTableViewCellIdentifier) as! TextEntryTableViewCell
            
            cell.titleLabel.text = "Special request (optional)"
            cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
            cell.textView.delegate = self
            
            return cell
        } else { // Quantity section
            let cell = tableView.dequeueReusableCell(withIdentifier: quantityTableViewCellIdentifier) as! QuantityTableViewCell
            
            cell.quantityStepper.value = Double(cartItem.quantity)
            cell.quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged(sender:)), for: .valueChanged)
            
            cell.titleLabel.text = "Quantity"
            cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
            
            return cell
        }
    }
    
    private func updatePriceLabels() {
        let priceString = cartItem.totalPrice.stringInBahrainiDinars
        itemDetailView.itemPriceLabel.text = priceString
        footerView.totalPriceLabel.text = priceString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (cartItem != nil) else { return 0 }
        
        if section == 0 {
            return rsItem.options.count
        } else {
            return 1
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == specialRequestSectionIndex || indexPath.section == quantitySectionIndex {
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
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}















