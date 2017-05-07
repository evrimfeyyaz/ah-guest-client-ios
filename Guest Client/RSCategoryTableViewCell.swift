//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import AlamofireImage

class RSCategoryTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    let categoryTitleLabel = StyledLabel(withStyle: .title2)
    let categoryDescriptionLabel = StyledLabel(withStyle: .cellDescription)
    var categoryImageView = ImageViewWithGradient(frame: CGRect.zero)
    
    var categoryImageURL: URL? {
        didSet {
            configureImageViewImage()
        }
    }
    
    // MARK: - Private properties
    
    private let containerView = UIView() // To add a pseudo-margin below the cell.
    
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
        selectionStyle = .none
        backgroundColor = .clear
        
        configureContainerView()
        configureImageView()
        configureImageViewImage()
        configureTitleStackView()
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = ThemeColors.blackRock.withAlphaComponent(0.3)
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
            ])
    }
    
    private func configureImageView() {
        containerView.addSubview(categoryImageView)
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        
        containerView.sendSubview(toBack: categoryImageView)
    }
    
    private func configureImageViewImage() {
        categoryImageView.image = nil
        
        if let url = categoryImageURL {
            categoryImageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2))
        }
    }
    
    private func configureTitleStackView() {
        let titleStackView = UIStackView(arrangedSubviews: [categoryTitleLabel, categoryDescriptionLabel])
        titleStackView.axis = .vertical
        titleStackView.distribution = .fillProportionally
        titleStackView.spacing = -5
        
        contentView.addSubview(titleStackView)
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            ])
    }
    
}

// MARK: -

class ImageViewWithGradient: UIImageView {
    
    // MARK: - Private properties
    
    private let gradient = CAGradientLayer()
    
    // MARK: - Initializers
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    func configureView() {
        gradient.colors = [UIColor.black.withAlphaComponent(0.85).cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        // To fix issues with Auto Layout.
        gradient.frame = self.bounds
    }
    
}
