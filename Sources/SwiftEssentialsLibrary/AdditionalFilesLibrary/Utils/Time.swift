//
//  Time.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

public func currentTimeMillis() -> Double {
    return Date().timeIntervalSince1970
}

public struct ElapsedTime {
    let seconds, minutes, hours, days, weeks, months, years: Int
}

public enum FilterTimescale {
    case week, month
}

public extension Date {
    func getElapsedTime(since date: Date) -> ElapsedTime {
        return self.timeIntervalSince1970.getElapsedTime(since: date.timeIntervalSince1970)
    }
}
public extension TimeInterval{
    func getElapsedTime(since timestamp: TimeInterval) -> ElapsedTime {
        let time = NSInteger(self)
        let elapsedTime = time - NSInteger(timestamp)

        let seconds = elapsedTime % 60
        let minutes = (elapsedTime / 60) % 60
        let hours = (elapsedTime / 3600)
        let days = hours / 24
        let weeks = days / 7
        let months = days / 30
        let years = months / 12

        return ElapsedTime(seconds: seconds, minutes: minutes, hours: hours, days: days, weeks: weeks, months: months, years: years)
    }
}

public extension Date {

    var daySuffix: String {
        let dayOfMonth = Calendar.current.component(.day, from: self)
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

public func getShortFormattedTimeString(timestamp: Double) -> String {
    let elapsedTimeSincePost = NSDate().timeIntervalSince1970.getElapsedTime(since: timestamp)
    
    //if the post happened today
    if elapsedTimeSincePost.years == 0 && elapsedTimeSincePost.months == 0 && elapsedTimeSincePost.days == 0 {
        //if seconds ago
        if elapsedTimeSincePost.hours == 0 && elapsedTimeSincePost.minutes == 0 {
            return "now"
        }
        //if if minutes ago
        else if elapsedTimeSincePost.hours == 0 {
            return String(elapsedTimeSincePost.minutes) + "min"
        }
        //if hours ago
        else {
            return String(elapsedTimeSincePost.hours) + "h"
        }
    }
    //if the post happened within the last week
    else if elapsedTimeSincePost.days < 7 {
        return String(elapsedTimeSincePost.days) + "d"
    }
    //if the post happened longer than a week ago
    else if elapsedTimeSincePost.weeks < 52 {
        return String(elapsedTimeSincePost.weeks) + "w"
    }
    return String(elapsedTimeSincePost.years) + "y"
}

public func getFormattedTimeStringForPost(timestamp: Double) -> String {
    let elapsedTimeSincePost = NSDate().timeIntervalSince1970.getElapsedTime(since: timestamp)
    //if seconds ago
    if elapsedTimeSincePost.hours == 0 && elapsedTimeSincePost.minutes == 0 {
        return "just now"
    }
    //if if minutes ago
    if elapsedTimeSincePost.hours == 0 {
        if elapsedTimeSincePost.minutes == 0 {
            return String(elapsedTimeSincePost.minutes) + "m ago"
        } else {
            return String(elapsedTimeSincePost.minutes) + "m ago"
        }
    }
    if elapsedTimeSincePost.days < 3 {
        //if today
        if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: currentTimeMillis()) {
            if (elapsedTimeSincePost.hours == 1) {
                return String(elapsedTimeSincePost.hours) + "h ago"
            } else {
                return String(elapsedTimeSincePost.hours) + "h ago"
            }
        }
        //if yesterday
        if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: Date.yesterday.timeIntervalSince1970) {
//            let myTimeInterval = TimeInterval(timestamp)
//            let thedate = Date(timeIntervalSince1970: myTimeInterval)
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US")
//            dateFormatter.dateFormat = "h:mma"
            return "yesterday" //+ dateFormatter.string(from: thedate).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
        }
    }
    
    //if within the last week
    if elapsedTimeSincePost.days < 7 {
        let myTimeInterval = TimeInterval(timestamp)
        let thedate = Date(timeIntervalSince1970: myTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: thedate)
    }
    
    //if within the last year
    if elapsedTimeSincePost.years < 1 {
        let myTimeInterval = TimeInterval(timestamp)
        let thedate = Date(timeIntervalSince1970: myTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: thedate)
    }
    return getDateNumbers(currentTimeMillis: timestamp)
}

public func getFormattedTimeStringForChat(timestamp: Double) -> String {
    let elapsedTimeSincePost = NSDate().timeIntervalSince1970.getElapsedTime(since: timestamp)
    
    if elapsedTimeSincePost.days < 3 {
        let myTimeInterval = TimeInterval(timestamp)
        let thedate = Date(timeIntervalSince1970: myTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h:mma"
        
        //if today
        if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: currentTimeMillis()) {
            return "today, " + dateFormatter.string(from: thedate).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
        }
        //if yesterday
        if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: Date.yesterday.timeIntervalSince1970) {
            return "yesterday, " + dateFormatter.string(from: thedate).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
        }
    }
    if elapsedTimeSincePost.days < 7 {
        return getRecentFormattedDate(currentTimeMillis: timestamp)
    } else if elapsedTimeSincePost.years < 1 {
        return getFormattedDate(currentTimeMillis: timestamp)
    }
    return getDateNumbers(currentTimeMillis: timestamp) //TODO: add the time, too
}

public func getFormattedTimeStringForConvo(timestamp: Double) -> String {
    let elapsedTimeSincePost = NSDate().timeIntervalSince1970.getElapsedTime(since: timestamp)
    
    if elapsedTimeSincePost.hours == 0 && elapsedTimeSincePost.minutes == 0 {
        return "just now"
    } else if elapsedTimeSincePost.hours == 0 {
        if elapsedTimeSincePost.minutes == 0 {
            return String(elapsedTimeSincePost.minutes) + "m ago"
        } else {
            return String(elapsedTimeSincePost.minutes) + "m ago"
        }
    } else if elapsedTimeSincePost.days < 3 {
        //if today
        if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: currentTimeMillis()) {
            if (elapsedTimeSincePost.hours == 1) {
                return String(elapsedTimeSincePost.hours) + "h ago"
            } else {
                return String(elapsedTimeSincePost.hours) + "h ago"
            }
        } else if getDayOfWeek(currentTimeMillis: timestamp) == getDayOfWeek(currentTimeMillis: Date.yesterday.timeIntervalSince1970) {
            return "yesterday"
        }
    } else if elapsedTimeSincePost.days < 7 {
        return getDayOfWeek(currentTimeMillis: timestamp)
    } else if elapsedTimeSincePost.years < 1 {
        return getDateOnly(currentTimeMillis: timestamp)
    }
    return getDateNumbers(currentTimeMillis: timestamp)
}

public func getDateNumbers(currentTimeMillis: Double) -> String {
    let myTimeInterval = TimeInterval(currentTimeMillis)
    let thedate = Date(timeIntervalSince1970: myTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    return dateFormatter.string(from: thedate)
}

public func daySuffix(from date: Date) -> String {
    let calendar = Calendar.current
    let dayOfMonth = calendar.component(.day, from: date)
    switch dayOfMonth {
    case 1, 21, 31: return "st"
    case 2, 22: return "nd"
    case 3, 23: return "rd"
    default: return "th"
    }
}

public func getDateOnly(currentTimeMillis: Double) -> String {
    let myTimeInterval = TimeInterval(currentTimeMillis)
    let thedate = Date(timeIntervalSince1970: myTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MMM d"
    
    return dateFormatter.string(from: thedate)
}

public func getDateAndTimeForNewPost(selectedDate: Date) -> (String, String) {
    let elapsedTimeSincePost = NSDate().timeIntervalSince1970.getElapsedTime(since: selectedDate.timeIntervalSince1970)
    
    let timeFormatter = DateFormatter()
    timeFormatter.locale = Locale(identifier: "en_US")
    timeFormatter.dateFormat = "h:mma"
    let time = timeFormatter.string(from: selectedDate).lowercased()
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")

    //if the post happened within the last week
    if elapsedTimeSincePost.days < 7 {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        let wasToday = dayFormatter.string(from: selectedDate) == dayFormatter.string(from: Date())
        let wasYesterday = dayFormatter.string(from: selectedDate) == dayFormatter.string(from: Date.yesterday)
        
        if wasToday {
            return ("today", time)
        } else if wasYesterday {
            return ("yest", time)
        } else {
            dateFormatter.dateFormat = "E"
            return (dateFormatter.string(from: selectedDate), time)
        }
    } else {
        dateFormatter.dateFormat = "MMM d"
        return (dateFormatter.string(from: selectedDate), time)
    }
}

//types of dates:
//45 seconds ago
//10 minutes ago
//2 hours ago
//Yesterday, 4:59pm
//Last Sun, 4:59pm
//Last Fri, 4:59pm
//Apr 4 at 4:59pm

//date formatting reference: https://stackoverflow.com/questions/35700281/date-format-in-swift
public func getFormattedDate(currentTimeMillis: Double) -> String {
    let myTimeInterval = TimeInterval(currentTimeMillis)
    let thedate = Date(timeIntervalSince1970: myTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MMM d, h:mma"
    
    return dateFormatter.string(from: thedate).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
}

public func getRecentFormattedDate(currentTimeMillis: Double) -> String {
    let myTimeInterval = TimeInterval(currentTimeMillis)
    let thedate = Date(timeIntervalSince1970: myTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "E, h:mma"
    
    return dateFormatter.string(from: thedate).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
}

public func getDayOfWeek(currentTimeMillis: Double) -> String {
    let myTimeInterval = TimeInterval(currentTimeMillis)
    let thedate = Date(timeIntervalSince1970: myTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter.string(from: thedate)
}

//MARK: - UISlider

public func getDateFromSlider(indexFromZeroToOne index: Float, timescale: FilterTimescale, lowercase: Bool) -> String {
    var dateString: String
    if timescale == .week {
        if index >= 1 - 1.0/7 {
            dateString = "today"
        }
        else if index >= 1 - 2.0/7 {
            dateString = "yesterday"
        }
        else {
            let millisecondsInADay = 86400000.0
            let millisecondsAgo = floor(6.999 - (7.0 * Double(index))) * millisecondsInADay
            dateString = getDayOfWeek(currentTimeMillis: currentTimeMillis() + millisecondsAgo)
        }
    }
    else { // timescale == .month
        if index >= 1 - 1.0/3 {
            dateString = "this week"
        }
        else if index >= 1 - 2.0/3 {
            dateString = "this month"
        }
        else {
            dateString = "all time"
        }
    }
    // If the user wants lowercase, only lowercase month timescales (bc days of week should always be capitalized)
    if lowercase {
        if timescale == .month || dateString == "today" || dateString == "yesterday" {
            return dateString.lowercased()
        }
    }
    return dateString
}

// In case you want to display the time of day of the post in the slider, too
//    let timeofday = index.truncatingRemainder(dividingBy: 1)
//    if timeofday < 0.33 {
//        dateString += " morning"
//    } else if timeofday < 0.67 {
//        dateString += " afternoon"
//    } else {
//        dateString += " evening"
//    }

public extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var lastWeek: Date { return Date().weekBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

public extension Date {
    
    func isMoreRecentThan(_ otherDate: Date) -> Bool {
        return self.timeIntervalSince1970 > otherDate.timeIntervalSince1970
    }
    
    func isSame(_ component: Calendar.Component, as otherDate: Date) -> Bool {
        return Calendar.current.component(component, from: self) == Calendar.current.component(component, from: otherDate)
    }
    
}

public extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
