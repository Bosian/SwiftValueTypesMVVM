//
//  WebAPITests.swift
//  WebAPITests
//
//  Created by Bobson on 2016/9/8.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import XCTest
import Library
import PromiseKit

@testable import WebAPI

final class WebAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupWebAPI()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// 設定連線主機及UserAgent
    private func setupWebAPI()
    {
        let host = "https://xxx"
        
        var webConfig = WebConfig.shared
        webConfig.setup(
            host,
            httpHeader: [:],
            globalErrorConfig: WebAPIErrorConfig(isEnable: true, callbackDelegate: self, alertHandler: nil),
            language: .zhTW,
            serverType: .test
        )
    }

}

// MARK: - Callback 共用
extension WebAPITests: WebConfigCallbackDelegate
{
    /**
     失敗共用
     
     - parameter model: 失敗的資料 or nil
     */
    func failCallback(_ error: Error, alertHandler: ((UIAlertAction) -> Void)?) {
        
    }
}
