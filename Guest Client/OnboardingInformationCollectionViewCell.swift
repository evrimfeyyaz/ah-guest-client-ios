//
//  OnboardingInformationCollectionViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class OnboardingInformationCollectionViewCell: UICollectionViewCell {
    
    let informationTitleLabel = StyledLabel(withStyle: .title2)
    let informationLabel = StyledLabel(withStyle: .body)
    
    var informationTitle: String {
        get { return informationTitleLabel.text ?? "" }
        set { informationTitleLabel.text = newValue }
    }
    
    var information: String {
        get { return informationLabel.text ?? "" }
        set { informationLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpViews()
    }
    
    func setUpViews() {
        // Set up the title label.
        informationTitleLabel.textAlignment = .center
        informationTitleLabel.numberOfLines = 0
        addSubview(informationTitleLabel)
        
        informationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationTitleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50),
            informationTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 22),
            informationTitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -22),
            ])
        
        // Set up the information label.
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 0
        addSubview(informationLabel)
        
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: informationTitleLabel.bottomAnchor, constant: -5),
            informationLabel.leadingAnchor.constraint(equalTo: informationTitleLabel.leadingAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: informationTitleLabel.trailingAnchor),
            informationLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -12)
            ])
    }
    
}
