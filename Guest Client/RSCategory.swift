//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class RSCategory {
    
    // MARK: - Public properties
    
    let id: Int
    let title: String
    let description: String?
    var imageURL: URL?
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    private static let session = URLSession.shared
    
    // MARK: - Initializers
    
    init?(json: [String: Any]) {
        guard
            let idString = json["id"] as? String,
            let attributes = json["attributes"] as? [String: Any],
            let title = attributes["title"] as? String
            else { return nil }
        
        self.id = Int(idString)!
        self.title = title
        self.description = attributes["description"] as? String
        
        if let imageURLStrings = attributes["image-urls"] as? [String: String?] {
            if UIScreen.main.scale == 1.0, let oneXImageURLString = imageURLStrings["@1x"] as? String {
                imageURL = URL(string: oneXImageURLString)
            } else if UIScreen.main.scale == 2.0, let twoXImageURLString = imageURLStrings["@2x"] as? String {
                imageURL = URL(string: twoXImageURLString)
            } else if let threeXImageURLString = imageURLStrings["@3x"] as? String {
                imageURL = URL(string: threeXImageURLString)
            }
        }
    }
    
    // MARK: - Public static methods
    
    static func all(completion: @escaping ([RSCategory]) -> Void) {
        var rsCategoryURLComponents = urlComponents
        rsCategoryURLComponents.path = "/v0/room-service/categories"
        
        Alamofire.request(rsCategoryURLComponents.url!).responseJSON { response in
            var rsCategories: [RSCategory] = []
            
            if let JSON = response.result.value as? [String: Any],
                let jsonData = JSON["data"] as? [[String: Any]] {
                
                for rsCategoryData in jsonData {
                    if let attributes = rsCategoryData["attributes"] as? [String: Any],
                        let title = attributes["title"] as? String,
                        title == "Arabic Mezzeh Selection" || title == "Main Fares" || title == "Kids Choice" {
                        continue
                    }
                    
                    if let rsCategory = RSCategory(json: rsCategoryData) {
                        rsCategories.append(rsCategory)
                    }
                }
            }
            
            completion(rsCategories)
        }

    }
}









