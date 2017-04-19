//
//  OnboardingViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI elements
    fileprivate let pageControl = UIPageControl()
    private let onboardingInformationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    // MARK: - Onboarding information data
    let onboardingInformationList = [
        OnboardingInformation(title: "Welcome to The K Hotel",
                              information: "You can use this app to order room service right from your phone."),
        OnboardingInformation(title: "More Coming Soon",
                              information: "Soon, you will be able to earn loyalty points, ask for a massage, get a taxi, and much more using this app."),
        OnboardingInformation(title: "Enjoy Your Stay",
                              information: "We hope you will enjoy your stay with us. Please do not hesitate to get in touch if there is anything we can help you with.")
        ]
    
    // MARK: - Private properties
    fileprivate let infoCellIdentifier = "infoCellIdentifier"

    // MARK: View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = ThemeImages.backgroundImage
        
        // Set up the logo.
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.addSubview(logoImageView)
        logoImageView.alhCenter(toView: view, withXOffset: 5, withYOffset: -100)
        
        // Set up the onboarding information view.
        onboardingInformationCollectionView.backgroundColor = .clear
        onboardingInformationCollectionView.isPagingEnabled = true
        onboardingInformationCollectionView.dataSource = self
        onboardingInformationCollectionView.delegate = self
        view.addSubview(onboardingInformationCollectionView)
        onboardingInformationCollectionView.alhAnchor(toTopAnchor: view.topAnchor,
                                                      toRightAnchor: view.rightAnchor,
                                                      toBottomAnchor: view.bottomAnchor,
                                                      toLeftAnchor: view.leftAnchor)
        onboardingInformationCollectionView.register(OnboardingInformationCollectionViewCell.self,
                                                     forCellWithReuseIdentifier: infoCellIdentifier)
        
        // Set up the page control.
        pageControl.numberOfPages = onboardingInformationList.count
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
        
        // Set up the navigation bar.
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 44))
        let skipBarButton = UIBarButtonItem(title: "Skip", style: .plain,
                                            target: self, action: #selector(skipOnboarding))
        let nextBarButton = UIBarButtonItem(title: "Next", style: .plain,
                                            target: self, action: #selector(goToNextPage))
        
        navigationItem.leftBarButtonItem = skipBarButton
        navigationItem.rightBarButtonItem = nextBarButton
        navigationBar.items = [navigationItem]
        navigationBar.delegate = self
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        // For some reason, needed to make the navigation bar background transparent.
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.addSubview(navigationBar)
    }
    
    @objc private func goToNextPage() {
        if let visibleItem = onboardingInformationCollectionView.indexPathsForVisibleItems.first {
            let nextItem = IndexPath(row: visibleItem.row + 1, section: visibleItem.section)
            
            if (nextItem.row < onboardingInformationCollectionView.numberOfItems(inSection: 0)) {
                onboardingInformationCollectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    @objc private func skipOnboarding() {
        let roomServiceStoryboard = UIStoryboard(name: "RoomService", bundle: nil)
        if let roomServiceCategoriesVC = roomServiceStoryboard.instantiateInitialViewController() {
            show(roomServiceCategoriesVC, sender: self)
        }
    }

}

// MARK: - Collection view flow layout delegate
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}

// MARK: - Collection view data source
extension OnboardingViewController: UICollectionViewDataSource {
    
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

// MARK: - Navigation bar delegate
extension OnboardingViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

struct OnboardingInformation {
    var title: String
    var information: String
}
