//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

public protocol ValueRepresentable {
    associatedtype ValueType
    var value: ValueType { get }
}
