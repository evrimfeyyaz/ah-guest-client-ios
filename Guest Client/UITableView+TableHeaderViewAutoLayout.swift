//
//  UITableView+TableHeaderViewAutoLayout.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/23/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

extension UITableView {
    
    // For some reason, this is needed if you are using Auto Layout in your header view.
    // From: https://gist.github.com/marcoarment/1105553afba6b4900c10
    func layoutTableHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func layoutTableFooterView() {
        guard let footerView = self.tableFooterView else { return }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let footerWidth = footerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[footerView(width)]", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: ["width": footerWidth], views: ["footerView": footerView])
        
        footerView.addConstraints(temporaryWidthConstraints)
        
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        
        let footerSize = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = footerSize.height
        var frame = footerView.frame
        
        frame.size.height = height
        footerView.frame = frame
        
        self.tableFooterView = footerView
        
        footerView.removeConstraints(temporaryWidthConstraints)
        footerView.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
