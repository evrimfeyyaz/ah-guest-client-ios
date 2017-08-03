//
//  Created by Evrim Persembe on 6/2/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class Reservation {
    let id: Int
    var checkInDate: Date
    var checkOutDate: Date
    var roomNumber: String?
    var confirmationCode: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let checkInDateString = json["check_in_date"] as? String,
            let checkOutDateString = json["check_out_date"] as? String,
            let confirmationCode = json["confirmation_code"] as? String
            else { return nil }
        
        self.id = id
        self.confirmationCode = confirmationCode
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let checkInDate = dateFormatter.date(from: checkInDateString),
            let checkOutDate = dateFormatter.date(from: checkOutDateString) {
            self.checkInDate = checkInDate
            self.checkOutDate = checkOutDate
        } else {
            return nil
        }
    }
}
