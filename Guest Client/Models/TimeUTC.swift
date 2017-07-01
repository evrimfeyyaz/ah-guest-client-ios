//
//  Created by Evrim Persembe on 6/22/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

struct TimeUTC: Comparable, CustomStringConvertible {
    var hour: Int
    var minute: Int
    
    var totalMinutes: Int {
        return minute + (hour * 60)
    }
    
    var totalSeconds: Int {
        return totalMinutes * 60
    }
    
    var description: String {
        return "\(hour):\(minute)"
    }
    
    init?(hourColonMinute: String) {
        let parts = hourColonMinute.components(separatedBy: ":")
        guard parts.count == 2, let hour = Int(parts[0]), let minute = Int(parts[1]) else { return nil }
        
        self.hour = hour
        self.minute = minute
    }
    
    init(date: Date) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        self.hour = calendar.component(.hour, from: date)
        self.minute = calendar.component(.minute, from: date)
    }
    
    func isBetween(startingTime: TimeUTC, endingTime: TimeUTC) -> Bool {
        // Times involving the same day.
        if startingTime <= endingTime {
            return self >= startingTime && self <= endingTime
        } else { // Ending time is in the next day.
            return self >= startingTime || self <= endingTime
        }
    }
    
    func description(inTimeZone timeZone: TimeZone) -> String {
        let localTimeInTotalSeconds = totalSeconds + timeZone.secondsFromGMT()
        let localTimeHour = (localTimeInTotalSeconds / (60*60)) % 24
        let localTimeMinute = (localTimeInTotalSeconds % (60*60)) / 60
        
        return String.init(format: "%02d:%02d", localTimeHour, localTimeMinute)
    }
    
    static func <(lhs: TimeUTC, rhs: TimeUTC) -> Bool {
        return lhs.totalMinutes < rhs.totalMinutes
    }
    
    static func ==(lhs: TimeUTC, rhs: TimeUTC) -> Bool {
        return lhs.totalMinutes == rhs.totalMinutes
    }
}
