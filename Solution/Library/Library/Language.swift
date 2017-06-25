//
//  File.swift
//  Library
//
//  Created by Bobson on 2016/10/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

/// 目前語言
public enum Language: String {
    case en = "en"
    case zhTW = "zh-tw"
    case zhHK = "zh-hk"
    case zhCN = "zh-cn"
    case ja = "ja"
    case ko = "ko"
    case th = "th"
    
    /// 取得目前語言
    public static var current: Language
    {
        guard let languageCode = Locale.current.languageCode else {
            return .en
        }
        
        switch languageCode {
        case "zh":
            
            guard let collatorIdentifier = Locale.current.collatorIdentifier else {
                return .zhTW
            }
            
            switch collatorIdentifier {
            case "zh-Hant-HK", "zh-Hant-MO":
                return .zhHK
                
            case let str where str.contains("Hans"):
                return .zhCN
                
            default:
                return .zhTW
            }
            
        default:
            guard let language = Language(rawValue: languageCode) else {
                return .en
            }
            
            return language
        }
    }
}
