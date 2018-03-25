//
//  Date.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension Date {
    
    func minDate() -> Date {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        components.year = -150
        
        return gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func maxDate() -> Date {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        components.year = 150
        
        return gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func toString(format:String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        let result = formatter.string(from: self)
        
        return result
    }
    
    func toLongString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        return dateFormatter.string(from: self).capitalized
    }
    
    var toUTC:String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: self)
        
        return result
    }
}
