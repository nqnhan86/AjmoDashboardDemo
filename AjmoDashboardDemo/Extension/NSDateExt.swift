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
    
    
    func formatDateTime(_ format: String = Constants.DAY_FORMAT, timeZone: String = "GMT") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormatter.string(from: self)
    }
}
