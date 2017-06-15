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
            return reservations.first {
                (Calendar.current.compare($0.checkInDate, to: Date(), toGranularity: .day) == .orderedSame ||
                    Calendar.current.compare($0.checkInDate, to: Date(), toGranularity: .day) == .orderedAscending) &&
                    (Calendar.current.compare(Date(), to: $0.checkOutDate, toGranularity: .day) == .orderedSame ||
                        Calendar.current.compare(Date(), to: $0.checkOutDate, toGranularity: .day) == .orderedAscending)
            }
        }
    }
    
    var currentOrUpcomingReservation: Reservation? {
        get {
            return reservations.filter {
                Calendar.current.compare(Date(), to: $0.checkOutDate, toGranularity: .day) == .orderedSame ||
                    Calendar.current.compare(Date(), to: $0.checkOutDate, toGranularity: .day) == .orderedAscending
                }.sorted {
                    Calendar.current.compare($0.0.checkInDate, to: $0.1.checkInDate, toGranularity: .day) == .orderedAscending
                }.first
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
