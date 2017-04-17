//
//  RoomServiceItemViewController.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/14/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RoomServiceItemViewController: UIViewController {
    
    @IBOutlet weak var itemTitle: TitleOneLabel!
    @IBOutlet weak var attributesView: UIStackView!
    @IBOutlet weak var itemPrice: UILabel!
    
    var itemId: Int?
    var item: RoomServiceItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        
        item = RoomServiceItem.getItem(itemId: 0)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = 0.8
        
        let attrString = NSMutableAttributedString(string: item!.title)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        itemTitle.attributedText = attrString
        
        for attribute in (item?.attributes)! {
            let attributeView = AttributeView()
            attributeView.title = attribute
            
            attributesView.addArrangedSubview(attributeView)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "BHD"
        numberFormatter.numberStyle = .currency
        let priceInLocale = numberFormatter.string(from: item!.price as NSDecimalNumber)
        itemPrice.text = priceInLocale
        itemPrice.font = Fonts.price?.withSize(18)
        itemPrice.textColor = Colors.bodyText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
