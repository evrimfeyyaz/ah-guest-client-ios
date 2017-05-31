//
//  RSSection.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RSSection {
    
    // MARK: - Public static properties
    
    let id: Int
    let title: String
    var isDefault: Bool {
        get { return title == "__default" }
    }
    
    private(set) var items: [RSItem] = []
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        
        let itemsJSON = json["items"].arrayValue
        for itemJSON in itemsJSON {
            let item = RSItem(json: itemJSON)
            
            if let item = item {
                self.items.append(item)
            }
        }
    }
    
    // MARK: - Public static methods
    
    static func all(byCategoryId categoryId: Int, completion: @escaping ([RSSection]) -> Void) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var rsSectionURLComponents = urlComponents
        rsSectionURLComponents.path = "/api/v0/room_service/categories/\(categoryId)/sections"
        
        sessionManager.request(rsSectionURLComponents.url!).responseJSON { response in
            var sections: [RSSection] = []
            
            let json = JSON(response.result.value!)
            
            for (_, subJSON):(String, JSON) in json {
                let section = RSSection(json: subJSON)
                
                if let section = section {
                    sections.append(section)
                }
            }
            
            completion(sections)
        }
    }
    
}
