//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    static let baseURLString = "https://dry-dawn-66033.herokuapp.com/api/v0"
    
    case createAuthentication(parameters: [String: Any])
    case createUser(parameters: [String: Any])
    case createReservationAssociation(parameters: [String: Any])
    case indexRoomServiceCategories
    case indexRoomServiceSections(categoryID: Int)
    case showRoomServiceItem(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .indexRoomServiceCategories, .indexRoomServiceSections, .showRoomServiceItem:
                return .get
            case .createAuthentication, .createUser, .createReservationAssociation:
                return .post
            }
        }
        
        let url: URL = {
            let relativePath: String
            
            switch self {
            case .createAuthentication:
                relativePath = "authentication"
            case .createUser:
                relativePath = "users"
            case .createReservationAssociation:
                relativePath = "reservation_associations"
            case .indexRoomServiceCategories:
                relativePath = "room_service/categories"
            case .indexRoomServiceSections(let categoryID):
                relativePath = "room_service/categories/\(categoryID)/sections"
            case .showRoomServiceItem(let id):
                relativePath = "room_service/items/\(id)"
            }
            
            var url = URL(string: APIRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .indexRoomServiceCategories, .indexRoomServiceSections, .showRoomServiceItem:
                return nil
            case .createAuthentication(let parameters):
                return parameters
            case .createUser(let parameters):
                return parameters
            case .createReservationAssociation(let parameters):
                return parameters
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let authToken = APIManager.shared.currentUser?.authToken,
            let userID = APIManager.shared.currentUser?.id {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("\(userID)", forHTTPHeaderField: "ah-user-id")
        }
        
        let encoding = JSONEncoding.default
        
        return try encoding.encode(urlRequest, with: params)
    }
}
