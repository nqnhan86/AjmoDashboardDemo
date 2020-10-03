//
//  NSDateExt.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 Opiyn. All rights reserved.
//

import Foundation

extension Date {
    static func dates(fromDate: Date, toDate: Date) -> [Date] {
        var dates = [Date]()
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            
            if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                date = newDate
            }
            else {
                break
            }
        }
        
        return dates
    }
    
    
    /**
     format NSDate to String formatted "HH:mm - dd/MM/yyyy". Pass another format string to change format
     */
    func formatDateTime(_ format: String = "HH:mm - dd/MM/yyyy", timeZone: String = "GMT") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormatter.string(from: self)
    }

    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }

    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    /**
     default format "MM/dd/yyyy"
     */
    func toString(_ format: String = "MM/dd/yyyy", locale: Locale? = nil) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let l = locale{
            dateFormatter.locale = l
        }
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func toISO8601String() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        return dateFormatter.string(from: self) + "Z"
    }
    
    func getElapsedInterval() -> String {
        
        var interval = (Calendar.current as NSCalendar).components(.year, from: self, to: Date(), options: []).year
        
        if interval! > 0 {
            return interval == 1 ? "\(interval) year" : "\(interval) years"
        }
        
        interval = (Calendar.current as NSCalendar).components(.month, from: self, to: Date(), options: []).month
        if interval! > 0 {
            return interval == 1 ? "\(interval) month" : "\(interval) months"
        }
        
        interval = (Calendar.current as NSCalendar).components(.day, from: self, to: Date(), options: []).day
        if interval! > 0 {
            return interval == 1 ? "\(interval) day" : "\(interval) days"
        }
        
        interval = (Calendar.current as NSCalendar).components(.hour, from: self, to: Date(), options: []).hour
        if interval! > 0 {
            return interval == 1 ? "\(interval) hour" : "\(interval) hours"
        }
        
        interval = (Calendar.current as NSCalendar).components(.minute, from: self, to: Date(), options: []).minute
        if interval! > 0 {
            return interval == 1 ? "\(interval) minute" : "\(interval) minutes"
        }
        
        return "a moment ago"
    }
}
