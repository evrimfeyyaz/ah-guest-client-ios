//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    static let baseURLString = Bundle.main.infoDictionary!["AH_API_URL"] as! String
    
    case createAuthentication(parameters: [String: Any])
    case getUser(id: Int)
    case createUser(parameters: [String: Any])
    case createReservationAssociation(userID: Int, parameters: [String: Any])
    case indexRoomServiceCategories
    case indexRoomServiceSubCategories(categoryID: Int)
    case showRoomServiceItem(id: Int)
    case createRoomServiceOrder(userID: Int, parameters: [String: Any])
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .indexRoomServiceCategories, .indexRoomServiceSubCategories, .showRoomServiceItem, .getUser:
                return .get
            case .createAuthentication, .createUser, .createReservationAssociation, .createRoomServiceOrder:
                return .post
            }
        }
        
        let url: URL = {
            let relativePath: String
            
            switch self {
            case .createAuthentication:
                relativePath = "authentication"
            case .getUser(let id):
                relativePath = "users/\(id)"
            case .createUser:
                relativePath = "users"
            case .createReservationAssociation(let userID, _):
                relativePath = "users/\(userID)/reservation_associations"
            case .indexRoomServiceCategories:
                relativePath = "room_service/categories"
            case .indexRoomServiceSubCategories(let categoryID):
                relativePath = "room_service/categories/\(categoryID)/sub_categories"
            case .showRoomServiceItem(let id):
                relativePath = "room_service/items/\(id)"
            case .createRoomServiceOrder(let userID, _):
                relativePath = "users/\(userID)/room_service/orders"
            }
            
            var url = URL(string: APIRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .indexRoomServiceCategories, .indexRoomServiceSubCategories, .showRoomServiceItem, .getUser:
                return nil
            case .createAuthentication(let parameters), .createUser(let parameters),
                 .createReservationAssociation(_, let parameters), .createRoomServiceOrder(_, let parameters):
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
