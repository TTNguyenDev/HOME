//
//  DateExtension.swift
//  HOME
//
//  Created by TT Nguyen on 1/23/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrent_MonthYear() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM_yyyy"
        return formatter.string(from: date)
    }
    
    static func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: currentDate)
    }
    
    static func getCurrent_MonthYearString() -> String {
        let year = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        let yearString = formatter.string(from: year)
        return  year.monthAsString() + yearString
    }
    
    static func getNextMonth() -> String {
        let year = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let yearString = yearFormatter.string(from: year)

        let currentMonth = Date()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        var nextMonth = Int(monthFormatter.string(from: currentMonth))! + 1
        
        if nextMonth == 13 {
            nextMonth = 1
            let yearAfterAdding = Int(yearFormatter.string(from: year))! + 1
            return String(nextMonth) + "-" + String(yearAfterAdding)
        }
        
        return String(nextMonth) + "-" + yearString
    }
    
    static func getLastMonth() -> String {
        let year = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let yearString = yearFormatter.string(from: year)
        
        let currentMonth = Date()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        var lastMonth = Int(monthFormatter.string(from: currentMonth))! - 1
        
        if lastMonth == 0 {
            lastMonth = 12
            let yearAfterAdding = Int(yearFormatter.string(from: year))! - 1
            return String(lastMonth) + "_" + String(yearAfterAdding)
        }
        
        return String(lastMonth) + "_" + yearString
    }
    
    
    
    static func getCurrentYear() -> String {
        let year = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let yearString = formatter.string(from: year)
        return  yearString
    }
    
    func monthAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        return dateFormatter.string(from: self)
    }
    
    static func getCurrentDay() -> Int {
        let day = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let dayString = formatter.string(from: day)
        return  Int(dayString)!
    }
    
    static func daysLeft() -> Int {
        let currentDate = Date()
        var constDate = "05-\(getNextMonth())"
        if getCurrentDay() <= 5 {
            let constDateFormatter = DateFormatter()
            constDateFormatter.dateFormat = "MM-yyyy"
            let formatedConstDate = constDateFormatter.string(from: currentDate)
            constDate = "05-\(formatedConstDate)"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formatedConstDate = dateFormatter.date(from: constDate)
        
        return Calendar.current.dateComponents([.day], from: currentDate, to: formatedConstDate!).day!
    }
}

extension NSNumber {
    var transferToCurrency:String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: self)!
    }
}


