//
//  Created by Evrim Persembe on 4/29/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCartViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private let cartItemTableViewCell = "cartItem"
    private let tableViewHeaderViewIdentifier = "tableViewHeader"
    
    private let footerView = RSCartFooterView()

    // MARK: - View configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        
        tableView.register(RSCartItemTableViewCell.self, forCellReuseIdentifier: cartItemTableViewCell)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderViewIdentifier)
        
        tableView.tableFooterView = footerView
        updateTotalPriceLabel()
        footerView.addMoreItemsButton.addTarget(self, action: #selector(addMoreItemsButtonTapped), for: .touchUpInside)
        footerView.checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        tableView.layoutTableHeaderOrFooterView(location: .footer)
    }
    
    private func configureNavigationBar() {
        let addMoreItemsBarButton = UIBarButtonItem(title: "Add More Items", style: .plain, target: self, action: #selector(addMoreItemsBarButtonTapped))
        
        navigationItem.leftBarButtonItem = addMoreItemsBarButton
        navigationItem.title = "Cart"
    }
    
    // MARK: - Actions
    
    @objc private func addMoreItemsBarButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func quantityStepperValueChanged(sender: UIStepper) {
        // TODO: This is really hacky, find a better way to do this.
        // From: http://stackoverflow.com/a/19000484
        let stepperCenterPoint = sender.center
        let rootViewPoint = sender.superview?.convert(stepperCenterPoint, to: tableView)
        let indexPath = tableView.indexPathForRow(at: rootViewPoint!)!
        
        RoomServiceCart.shared.cartItems[indexPath.row].quantity = Int(sender.value)
        
        let cell = tableView.cellForRow(at: indexPath) as! RSCartItemTableViewCell
        cell.itemPriceLabel.text = RoomServiceCart.shared.cartItems[indexPath.row].totalPrice.stringInBahrainiDinars
        
        updateTotalPriceLabel()
    }
    
    @objc private func addMoreItemsButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func checkoutButtonTapped() {
        if APIManager.shared.hasAuthenticatedUser {
            let orderSuccessfulVC = RSOrderSuccessfulViewController()
            
            show(orderSuccessfulVC, sender: self)
        } else {
            let rootVC = SignInViewController()
            rootVC.successCallback = { [weak self] in
                self?.checkoutButtonTapped()
            }
            let navigationVC = UINavigationController(rootViewController: rootVC)
            
            show(navigationVC, sender: self)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = RoomServiceCart.shared.cartItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cartItemTableViewCell) as! RSCartItemTableViewCell
        cell.itemTitleLabel.text = cartItem.item.title
        cell.itemPriceLabel.text = cartItem.totalPrice.stringInBahrainiDinars
        cell.optionsAndChoicesLabel.text = cartItem.choicesAndOptionsAsString()
        cell.quantityStepper.value = Double(cartItem.quantity)
        cell.quantityStepper.sendActions(for: .valueChanged)
        
        cell.quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged(sender:)), for: .valueChanged)
        
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomServiceCart.shared.cartItems.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderViewIdentifier) as! TableViewHeader
            headerView.titleLabel.text = "Items in Your Cart"
            headerView.contentView.backgroundColor = .clear
            
            return headerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    // MARK: - Private instance methods
    
    private func updateTotalPriceLabel() {
        footerView.totalPriceLabel.text = RoomServiceCart.shared.total.stringInBahrainiDinars
    }

}
