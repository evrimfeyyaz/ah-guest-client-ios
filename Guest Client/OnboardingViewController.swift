//
//  OnboardingViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardingPagesView: UICollectionView!
    
    let onboardingInformation = [
        OnboardingInformation(title: "Welcome to The K Hotel",
                              information: "You can use this app to order room service right from your phone."),
        OnboardingInformation(title: "More Coming Soon",
                              information: "Soon, you will be able to earn loyalty points, ask for a massage, get a taxi, and much more using this app."),
        OnboardingInformation(title: "Enjoy Your Stay",
                              information: "We hope you will enjoy your stay with us. Please do not hesitate to get in touch if there is anything we can help you with.")
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        pageControl.numberOfPages = onboardingInformation.count
    }
    
    @IBAction func goToNextPage(_ sender: Any) {
        if let visibleItem = onboardingPagesView.indexPathsForVisibleItems.first {
            let nextItem = IndexPath(row: visibleItem.row + 1, section: visibleItem.section)
            
            if (nextItem.row < onboardingPagesView.numberOfItems(inSection: 0)) {
                onboardingPagesView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
            }
        }
    }

}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingViewCell
        
        cell.title.text = onboardingInformation[indexPath.row].title
        cell.information.text = onboardingInformation[indexPath.row].information
        
        return cell
    }
}

extension OnboardingViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

struct OnboardingInformation {
    var title: String
    var information: String
}
