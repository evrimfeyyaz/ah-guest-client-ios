//
//  Created by Evrim Persembe on 5/1/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCartItemTableViewCell: UITableViewCell {

    // MARK: - Public properties
    
    let itemTitleLabel = StyledLabel(withStyle: .cellTitle)
    let itemOptionsAndChoicesLabel = StyledLabel(withStyle: .cellDescription)
    let itemPriceLabel = StyledLabel(withStyle: .cellPrice)
    let quantityStepper = UIStepper()
    
    // MARK: - Private properties
    
    private let innerStackView = UIStackView()
    private let quantityLabel = StyledLabel(withStyle: .cellDescription)
    private let lowerStackView = UIStackView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func configureView() {
        configureTitleLabel()
        configurePriceLabel()
        configureItemOptionsAndChoicesLabel()
        configureUpperStackView()
        configureQuantityLabel()
        configureQuantityStepper()
        configureLowerStackView()
        configureOuterStackView()
    }
    
    private func configureTitleLabel() {
        itemTitleLabel.numberOfLines = 0
        // I have absolutely no idea why, but the following is the only way to make this work.
        itemTitleLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
    }
    
    private func configurePriceLabel() {
        itemPriceLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
    }
    
    private func  configureItemOptionsAndChoicesLabel() {
        itemOptionsAndChoicesLabel.numberOfLines = 0
    }
    
    private func configureUpperStackView() {
        innerStackView.addArrangedSubview(itemTitleLabel)
        innerStackView.addArrangedSubview(itemPriceLabel)
        innerStackView.distribution = .fill
        innerStackView.alignment = .firstBaseline
    }
    
    private func configureQuantityLabel() {
        quantityLabel.textAlignment = .right
    }
    
    private func configureQuantityStepper() {
        quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged), for: .valueChanged)
        quantityStepper.minimumValue = 1
        quantityStepper.sendActions(for: .valueChanged)
    }
    
    private func configureLowerStackView() {
        lowerStackView.addArrangedSubview(quantityLabel)
        lowerStackView.addArrangedSubview(quantityStepper)
        
        lowerStackView.spacing = 10
    }
    
    private func configureOuterStackView() {
        let outerStackView = UIStackView(arrangedSubviews: [innerStackView, itemOptionsAndChoicesLabel, lowerStackView])
        outerStackView.axis = .vertical
        outerStackView.distribution = .equalCentering
        
        contentView.addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            outerStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    // MARK: - Actions
    
    @objc private func quantityStepperValueChanged() {
        updateQuantityLabel(withQuantity: Int(quantityStepper.value))
    }
    
    // MARK: - Private instance methods
    
    private func updateQuantityLabel(withQuantity quantity: Int) {
        quantityLabel.text = "Quantity: \(quantity)"
    }

}
