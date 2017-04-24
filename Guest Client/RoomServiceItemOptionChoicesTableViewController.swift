//
//  RoomServiceItemPreferenceChoicesTableViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/23/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemOptionChoicesTableViewController: UITableViewController {

    let choicesForOption: RoomServiceItemChoicesForOption
    
    private let tableViewCellIdentifier = "tableViewCellIdentifier"
    private let tableViewHeaderIdentifier = "tableViewHeaderIdentifier"
    
    init(choicesForOption: RoomServiceItemChoicesForOption) {
        self.choicesForOption = choicesForOption
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishChoosing))
//        doneButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .normal)
//        doneButton.setTitleTextAttributes([NSFontAttributeName: ThemeFonts.latoRegular.withSize(17)], for: .highlighted)
//        navigationItem.rightBarButtonItem = doneButton
        
        setUpViews()
    }
    
    func setUpViews() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the table view.
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = ThemeColors.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderIdentifier)
        
        if (choicesForOption.option.allowsMultipleChoices) {
            tableView.allowsMultipleSelection = true
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choicesForOption.numberOfPossibleChoices
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! TableViewCell
        let choice = choicesForOption.option.choices[indexPath.row]
        
        cell.titleLabel.text = choice.title
        
        if choice.price > 0 {
            cell.detailLabel.text = choice.price.stringInDefaultCurrency
        }
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderIdentifier) as! TableViewHeader
        
        var headerTitle = choicesForOption.option.title
        if (choicesForOption.option.isOptional) {
            headerTitle += " (optional)"
        }
        
        headerView.titleLabel.text = headerTitle
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

}
