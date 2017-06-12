//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class RoomServiceCartItemViewController: UITableViewController, UITextViewDelegate {
    // MARK: - Private properties
    private let itemDetailView = RSItemDetailView()
    private let footerView = RSCartItemFooterView()
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    private let tableViewCellIdentifier = "tableViewCell"
    private let textEntryTableViewCellIdentifier = "textEntry"
    private let quantityTableViewCellIdentifier = "quantity"
    
    private var cartItem: RoomServiceCartItem?
    private var roomServiceItemID: Int
    
    private let optionsSectionIndex = 0
    private let specialRequestSectionIndex = 1
    private let quantitySectionIndex = 2

    // MARK: - Initializers
    init(roomServiceItemID: Int) {
        self.roomServiceItemID = roomServiceItemID
        
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
        fetchRoomServiceItemAndCreateRoomServiceCartItem {
            if self.cartItem != nil {
                self.configureTableView()
                self.configureItemDetailView()
                self.configureTableFooterView()
            }
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
        guard let cartItem = cartItem else { return }
        
        itemDetailView.itemTitleLabel.text = cartItem.item.title
        itemDetailView.itemDescriptionLabel.text = cartItem.item.longDescription?.capitalizingFirstLetter()
        itemDetailView.itemPriceLabel.text = cartItem.item.price.stringInBahrainiDinars
        
        for tag in cartItem.item.tags {
            let tagView = TagView(title: tag.title)
            
            itemDetailView.tagsStackView.addArrangedSubview(tagView)
        }
        
        tableView.tableHeaderView = itemDetailView
        tableView.layoutTableHeaderOrFooterView(location: .header)
    }
    
    private func configureTableFooterView() {
        guard let cartItem = cartItem else { return }
        
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
        guard let cartItem = cartItem else { return }
        
        RoomServiceCart.shared.add(item: cartItem)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func quantityStepperValueChanged(sender: UIStepper) {
        guard let cartItem = cartItem else { return }
        
        cartItem.quantity = Int(sender.value)
        
        updatePriceLabels()
    }
    
    // MARK: - Public instance methods
    
    func optionChanged() {
        tableView.reloadData()
        updatePriceLabels()
    }
    
    // MARK: - Private instance methods
    
    private func fetchRoomServiceItemAndCreateRoomServiceCartItem(completion: @escaping () -> Void) {
        activityIndicatorView.startAnimating()
        
        APIManager.shared.showRoomServiceItem(id: roomServiceItemID) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            switch result {
            case .success(let item):
                self.cartItem = RoomServiceCartItem(item: item)
            case .failure(let error):
                let alertController = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            completion()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartItem = cartItem else { return UITableViewCell() }
        
        if indexPath.section == optionsSectionIndex {
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
        guard let cartItem = cartItem else { return }
        
        let priceString = cartItem.totalPrice.stringInBahrainiDinars
        itemDetailView.itemPriceLabel.text = priceString
        footerView.totalPriceLabel.text = priceString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cartItem = cartItem else { return 0 }
        
        if section == 0 {
            return cartItem.item.options.count
        } else {
            return 1
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cartItem = cartItem else { return }
        
        if indexPath.section == specialRequestSectionIndex || indexPath.section == quantitySectionIndex {
            return
        }
        
        let option = cartItem.item.options[indexPath.row]
        
        let optionVC: RoomServiceChoicesForOptionViewController
        if let choicesForOption = cartItem.choices(for: option) {
            optionVC = RoomServiceChoicesForOptionViewController(choicesForOption: choicesForOption)
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















