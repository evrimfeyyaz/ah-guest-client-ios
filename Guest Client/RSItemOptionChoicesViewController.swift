//
//  RSItemPreferenceChoicesTableViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/23/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSItemOptionChoicesViewController: UITableViewController {
    
    // MARK: - Public properties
    
    var itemViewController: RSCartItemViewController?
    
    // MARK: - Private properties

    private let choicesForOption: RSItemChoicesForOption
    
    private let tableViewCellIdentifier = "tableViewCell"
    private let tableViewHeaderIdentifier = "tableViewHeader"
    
    // MARK: - Initializers
    
    init(choicesForOption: RSItemChoicesForOption) {
        self.choicesForOption = choicesForOption
        
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
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderIdentifier)
        
        if (choicesForOption.option.allowsMultipleChoices) {
            tableView.allowsMultipleSelection = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        itemViewController?.optionChanged()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choicesForOption.numberOfPossibleChoices
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! TableViewCell
        let possibleChoice = choicesForOption.option.possibleChoices[indexPath.row]
        
        cell.titleLabel.text = possibleChoice.title
        
        if possibleChoice.price > 0 {
            cell.detailLabel.text = possibleChoice.price.stringInBahrainiDinars
        }
        cell.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        if choicesForOption.isChoiceSelected(possibleChoice) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            cell.accessoryType = .checkmark
        }
        
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
        let choice = choicesForOption.option.possibleChoices[indexPath.row]
        
        if (choicesForOption.option.allowsMultipleChoices) {
            let choicesForMultipleChoiceOption = choicesForOption as! RSItemChoicesForMultipleChoiceOption
            choicesForMultipleChoiceOption.addSelectedChoice(choice)
        } else {
            let choicesForSingleChoiceOption = choicesForOption as! RSItemChoicesForSingleChoiceOption
            choicesForSingleChoiceOption.makeSelectedChoice(choice: choice)
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if (choicesForOption.option.allowsMultipleChoices) {
            let choice = choicesForOption.option.possibleChoices[indexPath.row]
            let choicesForMultipleChoiceOption = choicesForOption as! RSItemChoicesForMultipleChoiceOption
            choicesForMultipleChoiceOption.removeSelectedChoice(choice)
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

}
