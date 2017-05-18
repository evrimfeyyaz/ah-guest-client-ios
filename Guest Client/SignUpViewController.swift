//
//  Created by Evrim Persembe on 5/18/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Private properties
    
    private let explanationLabel = StyledLabel(withStyle: .body)
    
    // MARK: - View configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureNavigationBar()
        configureExplanationLabel()
        configureLayoutViews()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Sign Up"
    }
    
    private func configureExplanationLabel() {
        explanationLabel.text = "Sign Up"
    }
    
    private func configureLayoutViews() {
        let scrollView = UIScrollView()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(explanationLabel)
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }

}
