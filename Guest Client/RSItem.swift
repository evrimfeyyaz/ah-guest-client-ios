//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RSItem {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let shortDescription: String?
    var longDescription: String?
    let price: Decimal
    var tags: [RSTag] = []
    var options: [RSOption] = []
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    private static let session = URLSession.shared
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.shortDescription = json["short_description"].stringValue
        
        let priceString = json["price"].stringValue
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        
        guard let price = formatter.number(from: priceString) as? Decimal else { return nil }
        self.price = price
    }
    
    // MARK: - Public instance methods
    
    func fetchItemDetails(completion: @escaping () -> Void) {
        var rsItemURLComponents = RSItem.urlComponents
        rsItemURLComponents.path = "/v0/room-service/items/\(id)"
        
        Alamofire.request(rsItemURLComponents.url!).responseJSON { response in
            if let JSON = response.result.value as? [String: Any],
                let jsonData = JSON["data"] as? [String: Any],
                let jsonIncludedArray = JSON["included"] as? [[String: Any]],
                let attributes = jsonData["attributes"] as? [String: Any] {
                
                self.longDescription = attributes["long-description"] as? String
                
                for jsonInclude in jsonIncludedArray {
                    if let objectType = jsonInclude["type"] as? String,
                        objectType == "room-service-item-attributes",
                        let itemAttribute = RSTag(jsonData: jsonInclude) {
                        self.tags.append(itemAttribute)
                    } else if let objectType = jsonInclude["type"] as? String,
                        objectType == "room-service-item-options",
                        let option = RSOption(jsonData: jsonInclude, jsonIncluded: jsonIncludedArray) {
                        self.options.append(option)
                    }
                }
            }
            
            completion()
        }
    }
    
}









