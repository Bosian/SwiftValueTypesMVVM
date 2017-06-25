//
//  StringExtension.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/1/25.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

extension Date {
    
    /**
     轉字串
     
     - parameter dateformat: "yyyy/MM/dd HH:mm:ss"
     - parameter locale:     時區 (不指定為抓取目前的時區)
     
     - returns: 格式化後的日期字串
     */
    public func toString(_ dateformat: String, locale: Locale, timeZone: TimeZone) -> String
    {
        let dateFormater = DateFormatter()
        
        dateFormater.locale = locale
        dateFormater.dateFormat = dateformat
        dateFormater.timeZone = timeZone
        
        let dateString = dateFormater.string(from: self)
        
        return dateString
    }
}
