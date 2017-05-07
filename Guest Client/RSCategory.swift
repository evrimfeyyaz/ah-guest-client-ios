//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCategory {
    
    // MARK: - Public properties
    
    let title: String
    let description: String?
    var imageURL: URL?
    
    // MARK: - Private static properties
    
    private static let urlString = "http://guest-api-app.dev"
    private static let urlComponents = URLComponents(string: urlString)!
    private static let session = URLSession.shared
    
    // MARK: - Initializers
    
    init?(json: [String: Any]) {
        guard
            let attributes = json["attributes"] as? [String: Any],
            let title = attributes["title"] as? String
            else { return nil }
        
        self.title = title
        self.description = attributes["description"] as? String
        
        if let imageURLStrings = attributes["image-urls"] as? [String: String?] {
            var imageURLComponents: URLComponents
            
            if UIScreen.main.scale == 1.0, let oneXImageURLString = imageURLStrings["@1x"] as? String {
                imageURLComponents = URLComponents(string: "\(RSCategory.urlString)/\(oneXImageURLString)")!
                imageURL = imageURLComponents.url
            } else if UIScreen.main.scale == 2.0, let twoXImageURLString = imageURLStrings["@2x"] as? String {
                imageURLComponents = URLComponents(string: "\(RSCategory.urlString)/\(twoXImageURLString)")!
                imageURL = imageURLComponents.url
            } else if let threeXImageURLString = imageURLStrings["@3x"] as? String {
                imageURLComponents = URLComponents(string: "\(RSCategory.urlString)/\(threeXImageURLString)")!
                imageURL = imageURLComponents.url
            }
        }
    }
    
    init(title: String, description: String?, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
    
    // MARK: - Public static methods
    
    static func all(completion: @escaping ([RSCategory]) -> Void) {
        var rsCategoryURLComponents = urlComponents
        rsCategoryURLComponents.path = "/v0/room-service/categories"
        
        let rsCategoryURL = rsCategoryURLComponents.url!
        
        session.dataTask(with: rsCategoryURL) { data, response, error in
            var rsCategories: [RSCategory] = []
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let jsonData = json!["data"] as? [[String: Any]] {
                
                for rsCategoryData in jsonData {
                    if let rsCategory = RSCategory(json: rsCategoryData) {
                        rsCategories.append(rsCategory)
                    }
                }
            }
            
            completion(rsCategories)
        }.resume()

    }
}









