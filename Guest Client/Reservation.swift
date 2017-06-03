//
//  Created by Evrim Persembe on 6/2/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Reservation {
    
    // MARK: - Public properties
    
    let id: Int
    var checkInDate: Date
    var checkOutDate: Date
    var roomNumber: Int
    var confirmationCode: String
    var firstName: String
    var lastName: String
    
    // MARK: - Initializers
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.roomNumber = json["room_number"].intValue
        self.confirmationCode = json["confirmation_code"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let checkInDateString = json["check_in_date"].string,
            let checkOutDateString = json["check_out_date"].string
            else { return nil }
        
        if let checkInDate = dateFormatter.date(from: checkInDateString),
            let checkOutDate = dateFormatter.date(from: checkOutDateString) {
            self.checkInDate = checkInDate
            self.checkOutDate = checkOutDate
        } else {
            return nil
        }
    }
}
