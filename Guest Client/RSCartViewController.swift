//
//  Created by Evrim Persembe on 4/29/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCartViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private let cartItemTableViewCell = "cartItem"

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
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonTapped))
        
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // MARK: - Actions
    
    @objc private func cancelBarButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func quantityStepperValueChanged(sender: UIStepper) {
        let stepperCenterPoint = sender.center
        let rootViewPoint = sender.superview?.convert(stepperCenterPoint, to: tableView)
        let indexPath = tableView.indexPathForRow(at: rootViewPoint!)!
        
        RSCart.shared.cartItems[indexPath.row].quantity = Int(sender.value)
        
        let cell = tableView.cellForRow(at: indexPath) as! RSCartItemTableViewCell
        cell.itemPriceLabel.text = RSCart.shared.cartItems[indexPath.row].totalPrice.stringInBahrainiDinars
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartItemTableViewCell) as! RSCartItemTableViewCell
        cell.itemTitleLabel.text = RSCart.shared.cartItems[indexPath.row].rsItem.title
        cell.itemPriceLabel.text = RSCart.shared.cartItems[indexPath.row].totalPrice.stringInBahrainiDinars
        cell.itemOptionsAndChoicesLabel.text = RSCart.shared.cartItems[indexPath.row].choicesAndOptionsAsString()
        
        cell.quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged(sender:)), for: .valueChanged)
        
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RSCart.shared.cartItems.count
    }

}
