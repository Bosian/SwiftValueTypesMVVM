//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

public protocol StringConvertable {
    func toString() -> String
}

extension StringConvertable
{
    public func toString() -> String
    {
        return "\(self)"
    }
}
