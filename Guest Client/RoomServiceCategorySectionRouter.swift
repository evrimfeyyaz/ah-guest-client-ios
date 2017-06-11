//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire

enum RoomServiceCategorySectionRouter: URLRequestConvertible{
    static let baseURLString = "https://dry-dawn-66033.herokuapp.com/api/v0"
    
    case index(roomServiceCategoryID: Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .index:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String
            
            switch self {
            case .index(let roomServiceCategoryID):
                relativePath = "room_service/categories/\(roomServiceCategoryID)/sections"
            }
            
            var url = URL(string: RoomServiceCategoryRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .index:
                return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        
        return try encoding.encode(urlRequest, with: params)
    }
}
