//
//  Created by Evrim Persembe on 6/1/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class User {
    
    // MARK: - Singleton
    
    static var shared: User? = nil
    
    // MARK: - Private static properties
    
    private static let urlString = "https://dry-dawn-66033.herokuapp.com"
    private static let urlComponents = URLComponents(string: urlString)!
    
    // MARK: - Public instance properties
    
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let authToken: String
    var reservations: [Reservation] = []
    var currentOrUpcomingReservationID: Int?
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.authToken = json["auth_token"].stringValue
        
        let currentOrUpcomingReservationJSON = json["current_or_upcoming_reservation"]
        if let reservation = Reservation(json: currentOrUpcomingReservationJSON) {
            self.reservations.append(reservation)
            currentOrUpcomingReservationID = reservation.id
        }
    }
    
    // MARK: - Public static methods
    
    static func authenticate(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = APIHeadersAdapter()
        
        var userURLComponents = User.urlComponents
        userURLComponents.path = "/api/v0/authentication"
        
        let parameters: Parameters = [
            "user": [
                "email": email,
                "password": password
            ]
        ]
        
        sessionManager.request(userURLComponents.url!,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate(statusCode: [200])
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    
                    if let user = User(json: json) {
                        User.shared = user
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(_):
                    completion(false)
                }
        }
    }
    
}
