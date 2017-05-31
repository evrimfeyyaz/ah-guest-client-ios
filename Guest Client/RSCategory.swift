//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RSCategory {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let description: String?
    var imageURL: URL?
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        
        let imageURLs = json["image_urls"].dictionaryValue
        
        if UIScreen.main.scale == 1.0, let oneXImageURLString = imageURLs["@1x"]?.stringValue {
            self.imageURL = URL(string: oneXImageURLString)
        } else if UIScreen.main.scale == 2.0, let twoXImageURLString = imageURLs["@2x"]?.stringValue {
            self.imageURL = URL(string: twoXImageURLString)
        } else if let threeXImageURLString = imageURLs["@3x"]?.stringValue {
            self.imageURL = URL(string: threeXImageURLString)
        }
    }
    
    // MARK: - Public static methods
    
    static func all(completion: @escaping ([RSCategory]) -> Void) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var rsCategoryURLComponents = urlComponents
        rsCategoryURLComponents.path = "/api/v0/room_service/categories"
        
        sessionManager.request(rsCategoryURLComponents.url!).responseJSON { response in
            var rsCategories: [RSCategory] = []
            
            let json = JSON(response.result.value!)
            
            for (_, subJSON):(String, JSON) in json {
                let category = RSCategory(json: subJSON)
                
                if let category = category {
                    rsCategories.append(category)
                }
            }
            
            completion(rsCategories)
        }
        
    }
}









