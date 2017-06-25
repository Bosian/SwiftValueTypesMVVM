//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 *  CellViewModel Button 可被點擊
 */
public protocol TouchUpInsideable
{
    var indexPath: IndexPath { get }
    var touchUpInsideHandler: (_ indexPath: IndexPath, _ oldValue: Any?, _ newValue: Any?, _ viewModel: Self) -> Void { get }
}
