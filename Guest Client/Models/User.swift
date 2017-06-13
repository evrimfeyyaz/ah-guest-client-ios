//
//  Created by Evrim Persembe on 6/1/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

class User {
    static var current: User? = nil
    
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    var reservations: [Reservation] = []
    let authToken: String
    
    var currentReservation: Reservation? {
        get {
            return reservations.first { $0.checkInDate <= Date() && $0.checkOutDate >= Date() }
        }
    }
    
    var currentOrUpcomingReservation: Reservation? {
        get {
            return reservations.filter { $0.checkInDate > Date() }
                .sorted { $0.0.checkInDate < $0.1.checkInDate }
                .first
        }
    }
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let email = json["email"] as? String,
            let firstName = json["first_name"] as? String,
            let lastName = json["last_name"] as? String,
            let authToken = json["auth_token"] as? String
            else { return nil }
        
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.authToken = authToken
        
        if let currentOrUpcomingReservationJSON = json["current_or_upcoming_reservation"] as? [String: Any],
            let reservation = Reservation(json: currentOrUpcomingReservationJSON) {
            self.reservations.append(reservation)
        }
    }
}
