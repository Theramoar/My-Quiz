//
//  Date Offset.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 16/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

extension Date {
    
    // Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        var offsetString = ""
        var timeCount = 0
        
        if years(from: date)   > 0 {
            timeCount = years(from: date)
            offsetString = "\(timeCount) years"
        }
        else if months(from: date)  > 0 {
            timeCount = months(from: date)
            offsetString = "\(timeCount) months"
        }
        else if weeks(from: date)   > 0 {
            timeCount = weeks(from: date)
            offsetString = "\(timeCount) weeks"
        }
        else if days(from: date)    > 0 {
            timeCount = days(from: date)
            offsetString = "\(timeCount) days"
        }
        else if hours(from: date) > 0 {
            timeCount = hours(from: date)
            offsetString = "\(timeCount) hours"
        }
        else if minutes(from: date) > 0 {
            timeCount = minutes(from: date)
            offsetString = "\(timeCount) minutes"
        }
        else if seconds(from: date) > 0 {
            timeCount = seconds(from: date)
            offsetString = "\(timeCount) seconds"
        }
        else { return "A while ago" }
        
        checkForPluralForm(timeCount, &offsetString)
        offsetString += " ago"
        
        return offsetString
    }
    
    // Returns the amount of years from another date
    private func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    // Returns the amount of months from another date
    private func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    // Returns the amount of weeks from another date
    private func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    // Returns the amount of days from another date
    private func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    // Returns the amount of hours from another date
    private func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    // Returns the amount of minutes from another date
    private func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    // Returns the amount of seconds from another date
    private func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    private func checkForPluralForm(_ number: Int, _ string: inout String) {
        if number == 1 {
            string.removeLast()
        }
    }
}
