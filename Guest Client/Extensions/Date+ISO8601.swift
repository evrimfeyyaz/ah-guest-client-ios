//
//  Created by Evrim Persembe on 6/12/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

// Adapted from: https://stackoverflow.com/a/28016692
extension Formatter {
    static let iso8601FullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension Date {
    var iso8601FullDate: String {
        return Formatter.iso8601FullDate.string(from: self)
    }
}

extension String {
    var dateFromISO8601FullDate: Date? {
        return Formatter.iso8601FullDate.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
}
