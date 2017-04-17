//
//  RoomServiceItemsTableViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemsTableViewController: UITableViewController {
    
    let roomServiceItemSections = RoomServiceItemSection.getAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return roomServiceItemSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomServiceItemSections[section].numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomServiceItem", for: indexPath) as! RoomServiceItemTableViewCell

        let section = indexPath.section
        let row = indexPath.row
        let item = roomServiceItemSections[section].items[row]
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "BHD"
        numberFormatter.numberStyle = .currency
        let priceInLocale = numberFormatter.string(from: item.price as NSDecimalNumber)
        
        cell.itemTitle.text = item.title
        cell.itemDescription.text = item.description
        cell.itemPrice.text = priceInLocale
        cell.itemId = item.id
        
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let sectionTitleLabel = StyledLabel()
        sectionTitleLabel.style = .tableHeader
        headerView.addSubview(sectionTitleLabel)
        
        sectionTitleLabel.text = roomServiceItemSections[section].title
        sectionTitleLabel.sizeToFit()
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.layoutMargins = UIEdgeInsets(top: 10, left: 8, bottom: 3, right: 10)
        let headerMargins = headerView.layoutMarginsGuide
        sectionTitleLabel.leadingAnchor.constraint(equalTo: headerMargins.leadingAnchor).isActive = true
        sectionTitleLabel.bottomAnchor.constraint(equalTo: headerMargins.bottomAnchor).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return roomServiceItemSections[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowItemDetail") {
            let destination = segue.destination as! RoomServiceItemViewController
            let itemId = (sender as? RoomServiceItemTableViewCell)?.itemId
    
            destination.itemId = itemId
        }
    }

}
