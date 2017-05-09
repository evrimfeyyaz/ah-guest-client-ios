//
//  RSSection.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/13/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire

class RSSection {
    
    // MARK: - Public static properties
    
    let id: Int
    let title: String
    let isDefault: Bool
    
    private(set) var items: [RSItem] = []
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    private static let session = URLSession.shared
    
    // MARK: - Initializers
    
    init?(json: [String: Any], jsonIncluded: [[String: Any]]? = nil) {
        guard
            let idString = json["id"] as? String,
            let attributes = json["attributes"] as? [String: Any],
            let title = attributes["title"] as? String,
            let isDefault = attributes["default"] as? Bool
            else { return nil }
        
        self.id = Int(idString)!
        self.title = title
        self.isDefault = isDefault
        
        if let relationships = json["relationships"] as? [String: Any],
            let itemReferencesJSON = relationships["items"] as? [String: Any],
            let itemReferencesDataJSON = itemReferencesJSON["data"] as? [[String: Any]] {
            
            if let jsonIncluded = jsonIncluded {
                for itemReferenceDataJSON in itemReferencesDataJSON {
                    if let itemIDString = itemReferenceDataJSON["id"] as? String {
                        let itemJSON = jsonIncluded.first(where: {
                            if let includedItemID = $0["id"] as? String {
                                return includedItemID == itemIDString
                            }
                            
                            return false
                        })
                        
                        if let itemJSON = itemJSON,
                            let item = RSItem(jsonData: itemJSON) {
                            items.append(item)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Public static methods
    
    static func all(byCategoryId categoryId: Int, completion: @escaping ([RSSection]) -> Void) {
        var rsSectionURLComponents = urlComponents
        rsSectionURLComponents.path = "/v0/room-service/categories/\(categoryId)/sections"
        
        Alamofire.request(rsSectionURLComponents.url!).responseJSON { response in
            var sections: [RSSection] = []
            
            if let JSON = response.result.value as? [String: Any],
                let jsonDataArray = JSON["data"] as? [[String: Any]],
                let jsonIncludedArray = JSON["included"] as? [[String: Any]] {
                
                for jsonData in jsonDataArray {
                    if let section = RSSection(json: jsonData, jsonIncluded: jsonIncludedArray) {
                        sections.append(section)
                    }
                }
            }
            
            completion(sections)
        }
    }
    
}
