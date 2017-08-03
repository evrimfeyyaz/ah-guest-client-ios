//
//  OnboardingInformationCollectionViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class OnboardingInformationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    let informationTitleLabel = StyledLabel(withStyle: .title2Centered)
    let informationLabel = StyledLabel(withStyle: .body)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func configureView() {
        configureTitleLabel()
        configureInformationLabel()
        configureOuterStackView()
    }
    
    private func configureTitleLabel() {
        informationTitleLabel.textAlignment = .center
        informationTitleLabel.numberOfLines = 0
    }
    
    private func configureInformationLabel() {
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 0
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [informationTitleLabel, informationLabel])
        outerStackView.axis = .vertical
        outerStackView.distribution = .equalSpacing
        
        contentView.addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
            outerStackView.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50),
            outerStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -12)
            ])
    }
    
}
