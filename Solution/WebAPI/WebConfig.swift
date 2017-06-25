//
//  WebConfig.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/1/17.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library

/// 由App設定連線所需資訊
public struct WebConfig {
    
    public private(set) static var shared = WebConfig()
    
    /// 是否"預設"啟用全域的錯誤處理，也可每支各別設定
    public private(set) var globalErrorConfig: WebAPIErrorConfig = WebAPIErrorConfig(isEnable: false, callbackDelegate: nil, alertHandler: nil)
    
    /// 連線中的主機的版本 (測試機 或 正式機)
    public private(set) var serverType: ServerTypes = .test
    
    /// 連線主機
    private(set) var host: String = ""

    /// HTTP header
    private(set) var httpHeader: [HTTPHeader: String] = [:]
    
    /// 裝置目前語系
    private(set) var language: Language = .en
    
    private init() {
        
    }
    
    public mutating func setup(_ host: String, httpHeader: [HTTPHeader: String] = [:], globalErrorConfig: WebAPIErrorConfig, language: Language, serverType: ServerTypes) {
        self.host = host
        self.httpHeader = httpHeader
        self.globalErrorConfig = globalErrorConfig
        self.language = language
        self.serverType = serverType
        
        WebConfig.shared = self
    }
    
}
