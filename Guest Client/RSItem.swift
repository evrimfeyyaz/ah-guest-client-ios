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
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var rsItemURLComponents = RSItem.urlComponents
        rsItemURLComponents.path = "/api/v0/room_service/items/\(id)"
        
        sessionManager.request(rsItemURLComponents.url!).responseJSON { response in
            let json = JSON(response.result.value!)
            
            self.longDescription = json["long_description"].stringValue
            
            let tagsJSON = json["tags"].arrayValue
            for tagJSON in tagsJSON {
                if let tag = RSTag(json: tagJSON) {
                    self.tags.append(tag)
                }
            }
            
            let optionsJSON = json["options"].arrayValue
            for optionJSON in optionsJSON {
                if let option = RSOption(json: optionJSON) {
                    self.options.append(option)
                }
            }
            
            completion()
        }
    }
    
}









