//
//  Created by Evrim Persembe on 4/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class RSCategory {
    
    // MARK: - Public properties
    
    let title: String
    let description: String?
    let image: UIImage?
    
    // MARK: - Private static properties
    
    private static let urlCompontents = URLComponents(string: "http://guest-api-app.dev")!
    private static let session = URLSession.shared
    
    // MARK: - Initializers
    
    init?(json: [String: Any]) {
        guard
            let attributes = json["attributes"] as? [String: Any],
            let title = attributes["title"] as? String
            else { return nil }
        
        self.title = title
        self.description = attributes["description"] as? String
        self.image = nil
    }
    
    init(title: String, description: String?, image: UIImage?) {
        self.title = title
        self.description = description
        self.image = image
    }
    
    // MARK: - Public static methods
    
    static func all(completion: @escaping ([RSCategory]) -> Void) {
        var rsCategoryURLComponents = urlCompontents
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









