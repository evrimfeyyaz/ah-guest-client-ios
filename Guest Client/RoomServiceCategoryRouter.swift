//
//  Created by Evrim Persembe on 6/10/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire

enum RoomServiceCategoryRouter: URLRequestConvertible {
    static let baseURLString = "https://dry-dawn-66033.herokuapp.com/api/v0"
    
    case index
    
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
            case .index:
                relativePath = "room_service/categories"
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
