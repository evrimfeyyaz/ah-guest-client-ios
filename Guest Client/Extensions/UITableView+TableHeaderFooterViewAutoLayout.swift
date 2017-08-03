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
    // Adapted rom: https://gist.github.com/marcoarment/1105553afba6b4900c10
    func layoutTableHeaderOrFooterView(location: TableHeaderOrFooterView) {
        guard let view = (location == .header ? self.tableHeaderView : self.tableFooterView)
            else { return }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let width = view.bounds.size.width;
        let widthAnchor = view.widthAnchor.constraint(equalToConstant: width)
        widthAnchor.isActive = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        let size = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = size.height
        var frame = view.frame
        
        frame.size.height = height
        frame.origin.x = 0
        frame.origin.y = 0
        view.frame = frame
        
        if (location == .header) {
            self.tableHeaderView = view
        } else {
            self.tableFooterView = view
        }
        
        widthAnchor.isActive = false
        view.translatesAutoresizingMaskIntoConstraints = true
    }
    
}

enum TableHeaderOrFooterView {
    case header
    case footer
}
