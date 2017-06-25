//
//  MirrorExtension.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/1/17.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit
import Library

/**
 目前語言
 */
extension Language {
    
    private var bundleName: String
    {
        switch self {
        case .en: return "Base"
        case .zhTW: return "zh-Hant-TW"
        case .zhHK: return "zh-Hant-HK"
        case .zhCN: return "zh-Hans"
        case .ja: return "ja"
        case .ko: return "ko"
        case .th: return "th"
        }
    }
    
    /// 取得別的語系的Bundle
    private var languageBundle: Bundle? {
        
        guard let path = Bundle.main.path(forResource: bundleName, ofType: "lproj") else {
            return nil
        }
        
        return Bundle(path: path)
    }
    
    /// 取得指定語系的多國語言
    ///
    /// - parameter language:       language description
    /// - parameter key:            key description
    /// - parameter defaultValue:   defaultValue description
    /// - parameter storyboardName: storyboardName description
    ///
    /// - returns: return value description
    public func localizeForLanguage(key: String, defaultValue: String = "", storyboardName: String = "") -> String
    {
        guard let bundle = languageBundle else {
            return defaultValue
        }
        
        return bundle.localizedString(forKey: key, value: defaultValue, table: storyboardName)
    }
    
}
