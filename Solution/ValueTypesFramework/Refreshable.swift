//
//  Refreshable.swift
//  ValueTypesFramework
//
//  Created by Bobson on 2016/11/9.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

public protocol Refreshable {
    
    /// 更新資料
    mutating func refresh(callback: (() -> Void)?)
}
