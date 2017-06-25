//
//  Global.swift
//  BooKingForUser
//
//  Created by Bobson on 2017/2/16.
//  Copyright © 2017年 Bobson. All rights reserved.
//

/// 只在Debug Mode輸出Print
///
/// - Parameter items: items description
func print(_ items: Any...)
{
    #if DEBUG
        for item in items
        {
            print(item, separator: " ", terminator: "\n")
        }
    #endif
}
