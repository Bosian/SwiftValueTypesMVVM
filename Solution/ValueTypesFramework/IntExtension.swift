//
//  IntExtension.swift
//  ValueTypesFramework
//
//  Created by Bobson on 2017/1/17.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import Library

extension Int {
    
    /// 取得本地化的月份 e.g.: 1月 or January
    ///
    /// - Parameter locale: locale description
    /// - Returns: return value description
    public var localizedMonth: String {
        
        let month = self
        guard case 1...12 = month else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        
        switch Language.current {
        case .zhTW, .zhHK, .zhCN:
            dateFormatter.locale = .tw
            
        case .en, .ko, .th:
            dateFormatter.locale = .us
            
        case .ja:
            dateFormatter.locale = .jp
        }
        
        return dateFormatter.monthSymbols[month - 1]
    }

}
