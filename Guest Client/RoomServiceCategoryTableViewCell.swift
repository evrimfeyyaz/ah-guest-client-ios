//
//  RoomServiceCategoryTableViewCell.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: TitleOneLabel!
    @IBOutlet weak var categoryDescription: SubtitleLabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
