//
//  WebAPIErrorConfig.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2017/5/25.
//  Copyright © 2017年 Bobson. All rights reserved.
//

public struct WebAPIErrorConfig {
    public var isEnable: Bool
    public var callbackDelegate: WebConfigCallbackDelegate?
    public var alertHandler: ((UIAlertAction) -> Void)?
    
    public init(isEnable: Bool, callbackDelegate: WebConfigCallbackDelegate?, alertHandler: ((UIAlertAction) -> Void)?) {
        self.isEnable = isEnable
        self.callbackDelegate = callbackDelegate
        self.alertHandler = alertHandler
    }
}
