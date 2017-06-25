//
//  StringExtension.swift
//  WebAPI
//
//  Created by Bobson on 2016/1/25.
//  Copyright © 2016年 Bobson. All rights reserved.
//



extension Date {
    
    /**
     星期幾
     
     - sunday:    sunday description
     - monday:    monday description
     - tuesday:   tuesday description
     - wednesday: wednesday description
     - thursday:  thursday description
     - friday:    friday description
     - saturday:  saturday description
     */
    public enum WeekTypes: Int, StringConvertable {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        public func toString() -> String
        {
            switch self {
            case .sunday:
                return "Sun."
            case .monday:
                return "Mon."
            case .tuesday:
                return "Tue."
            case .wednesday:
                return "Wed."
            case .thursday: 
                return "Thu."
            case .friday: 
                return "Fri."
            case .saturday: 
                return "Sat."
            }
        }
    }
    
    /**
     取得星期幾
     */
    public var dayOfWeek: WeekTypes
    {
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: self)
        
        return WeekTypes(rawValue: myComponents.weekday!)!
    }
    
    /// 轉字串
    ///
    /// - Parameters:
    ///   - format: "yyyy/MM/dd HH:mm:ss" or "yyy/MM/dd" (民國年)
    ///   - locale: 地區
    ///   - timeZone: 時區
    ///   - calendar: 日曆
    /// - Returns: String
    public func toString(_ format: String, locale: Locale, timeZone: TimeZone, calendar: Calendar = .current) -> String
    {
        let dateFormater = DateFormatter()
        
        dateFormater.locale = locale
        dateFormater.dateFormat = format
        dateFormater.timeZone = timeZone
        dateFormater.calendar = calendar
        
        return dateFormater.string(from: self)
    }
}

extension Date {
    
    public var year: Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
    
    public var month: Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
    
    public var day: Int {
        return Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    public var hour: Int {
        return Calendar.current.dateComponents([.hour], from: self).hour ?? 0
    }
    
    public var minute: Int {
        return Calendar.current.dateComponents([.minute], from: self).minute ?? 0
    }
    
    /// Returns the amount of years from another date
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Returns the amount of months from another date
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of weeks from another date
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    /// Returns the amount of days from another date
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns the amount of hours from another date
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the amount of seconds from another date
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    public func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
