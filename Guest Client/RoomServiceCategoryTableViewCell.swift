//
//  RSCategoryTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCategoryTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let categoryTitleLabel = StyledLabel(withStyle: .titleOne)
    private let categoryDescriptionLabel = StyledLabel(withStyle: .cellDescription)
    private var categoryImageView: RSCategoryImageView? = nil
    
    var categoryTitle: String {
        get { return categoryTitleLabel.text ?? "" }
        set { categoryTitleLabel.text = newValue }
    }
    
    var categoryDescription: String? {
        get { return categoryDescriptionLabel.text }
        set { categoryDescriptionLabel.text = newValue }
    }
    
    var categoryImage: UIImage? {
        get { return categoryImageView?.image }
        set {
            if (newValue == nil) {
                categoryImageView?.removeFromSuperview()
                categoryImageView = nil
                
                return
            }
            
            if (categoryImageView == nil) {
                categoryImageView = RSCategoryImageView(image: newValue)
                setUpImageView()
            } else {
                categoryImageView?.image = newValue
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpViews()
    }
    
    private func setUpViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        // Set up the container view to show a margin below the cell.
        contentView.addSubview(containerView)
        containerView.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -ThemeMeasurements.tableViewCellBottomMargin)
            ])
        
        // Set up the image view.
        setUpImageView()
        
        // Set up the title label.
        containerView.addSubview(categoryTitleLabel)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            categoryTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
        
        // Set up the description label.
        containerView.addSubview(categoryDescriptionLabel)
        categoryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryDescriptionLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: -10),
            categoryDescriptionLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
            categoryDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -28)
            ])
    }
    
    private func setUpImageView() {
        if let categoryImageView = categoryImageView {
            containerView.addSubview(categoryImageView)
            categoryImageView.alhAnchor(toTopAnchor: containerView.topAnchor, toRightAnchor: containerView.rightAnchor,
                                        toBottomAnchor: containerView.bottomAnchor, toLeftAnchor: containerView.leftAnchor)
            containerView.sendSubview(toBack: categoryImageView)
        }
    }
    
}
