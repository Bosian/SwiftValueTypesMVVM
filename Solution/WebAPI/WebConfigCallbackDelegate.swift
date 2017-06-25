//
//  WebConfigCallbackDelegate.swift
//  WebAPI
//
//  Created by Bobson on 2016/6/15.
//  Copyright © 2016年 Bobson. All rights reserved.
//

/**
 * WebAPI callback共用
 */
public protocol WebConfigCallbackDelegate
{
    /// 失敗共用
    ///
    /// - Parameters:
    ///   - error: 錯誤資訊
    ///   - alertHandler: Alert 按鈕 handler (可選)
    func failCallback(_ error: Error, alertHandler: ((_ action: UIAlertAction) -> Void)?)
}
