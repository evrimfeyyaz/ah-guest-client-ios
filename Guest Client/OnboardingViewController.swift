//
//  OnboardingViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: - Private properties
    
    private let onboardingInformationList = [
        OnboardingInformation(title: "Welcome to The K Hotel",
                              information: "You can use this app to order room service right from your phone."),
        OnboardingInformation(title: "More Coming Soon",
                              information: "Soon, you will be able to earn loyalty points, ask for a massage, get a taxi, and much more using this app."),
        OnboardingInformation(title: "Enjoy Your Stay",
                              information: "We hope you will enjoy your stay with us. Please do not hesitate to get in touch if there is anything we can help you with.")
    ]
    
    private let pageControl = UIPageControl()
    private let onboardingInformationCollectionView = UICollectionView(frame: CGRect.zero,
                                                                       collectionViewLayout: UICollectionViewFlowLayout())
    
    private let infoCellIdentifier = "info"

    // MARK: - View configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        configureLogoImageView()
        configureOnboardingInformationCollectionView()
        configurePageControl()
        configureNavigationBar()
    }
    
    private func configureLogoImageView() {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
            ])
    }
    
    private func configureOnboardingInformationCollectionView() {
        if let layout = onboardingInformationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        onboardingInformationCollectionView.backgroundColor = .clear
        onboardingInformationCollectionView.isPagingEnabled = true
        onboardingInformationCollectionView.dataSource = self
        onboardingInformationCollectionView.delegate = self
        onboardingInformationCollectionView.register(OnboardingInformationCollectionViewCell.self,
                                                     forCellWithReuseIdentifier: infoCellIdentifier)
        
        view.addSubview(onboardingInformationCollectionView)
        onboardingInformationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingInformationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingInformationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingInformationCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingInformationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func configurePageControl() {
        pageControl.numberOfPages = onboardingInformationList.count
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureNavigationBar() {
        let skipBarButton = UIBarButtonItem(title: "Skip", style: .plain,
                                            target: self, action: #selector(skipBarButtonTapped))
        let nextBarButton = UIBarButtonItem(title: "Next", style: .plain,
                                            target: self, action: #selector(nextBarButtonTapped))
        
        navigationItem.leftBarButtonItem = skipBarButton
        navigationItem.rightBarButtonItem = nextBarButton
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        // For some reason, these are needed to make the navigation bar background transparent:
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Actions
    
    @objc private func nextBarButtonTapped() {
        showNextInfoPage()
    }
    
    @objc private func skipBarButtonTapped() {
        finishOnboarding()
    }
    
    // MARK: - Private methods
    
    private func showNextInfoPage() {
        if let currentItem = onboardingInformationCollectionView.indexPathsForVisibleItems.first {
            let nextItemIndexPath = IndexPath(row: currentItem.row + 1, section: currentItem.section)
            
            if (nextItemIndexPath.row < onboardingInformationCollectionView.numberOfItems(inSection: 0)) {
                onboardingInformationCollectionView.scrollToItem(at: nextItemIndexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    private func finishOnboarding() {
        let rsCategoriesVC = RSCategoriesViewController()
        let navigationController = UINavigationController(rootViewController: rsCategoriesVC)
        
        show(navigationController, sender: self)
    }
    
    // MARK: - Collection view flow layout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingInformationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellIdentifier,
                                                          for: indexPath) as! OnboardingInformationCollectionViewCell
        
        infoCell.informationTitle = onboardingInformationList[indexPath.row].title
        infoCell.information = onboardingInformationList[indexPath.row].information
        
        return infoCell
    }

}

// MARK: -

struct OnboardingInformation {
    var title: String
    var information: String
}
