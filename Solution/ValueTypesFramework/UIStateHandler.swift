//
//  UIState.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/8/31.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

protocol UIStateHandler: AnyObject {
    
    associatedtype ViewType
    associatedtype ValueType: Equatable
    
    func handleView(_ view: ViewType, value: UIState<ValueType, Any?>)
}
