//
//  UserAgent.swift
//  WebAPI
//
//  Created by Bobson on 2016/1/14.
//  Copyright © 2016年 Sonet. All rights reserved.
//

import UIKit

class UserAgentManager: NSObject {

    static let shareUserAgent = UserAgentManager()
    
    /**
     * 裝置識別碼
     */
    var device_id: String?
    
    /**
     * App 版本(內部用)
     */
    var app_version_code: String?
    
    /**
     * App 版本(外部用)
     */
    var app_version_name: String?
    
    /**
     * SDK版本
     */
    var sdk_int: String?
    
    /**
     * 使用者的iOS版本
     */
    var sdk_release: String?
    
    /**
     * 裝置名稱
     */
    var device: String?
    
    private override init() {
        
        let device = UIDevice.currentDevice()
        let bundle = NSBundle(identifier: "tw.sonet.app")!

        self.device_id = device.identifierForVendor?.UUIDString ?? ""
        self.app_version_code = bundle.valueForKey("CFBundleVersion")?.value
        self.app_version_name = bundle.valueForKey("CFBundleShortVersionString")?.value
        self.sdk_int = __IPHONE_OS_VERSION_MIN_REQUIRED.description
        self.sdk_release = "iOS\(device.systemVersion)"
        self.device = device.modelName
    }
    
//    {
//    "device_id": 1234,
//    "app_version_code": 1,
//    "app_version_name": "1.0.1",
//    "sdk_int": 23,
//    "sdk_release": 6,
//    "device": "htc_m8"
//    }
}
