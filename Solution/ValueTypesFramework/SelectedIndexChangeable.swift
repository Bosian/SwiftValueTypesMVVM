//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 *  CellViewModel 內的 索引變更
 */
public protocol SelectedIndexChangeable
{
    var index: Int { get set }
    var selectedIndex: Int? { get set }
    var isDisplayList: Bool { get set }
    var valueChangeHandler: ((_ index: Int, _ selectedIndex: Int?, _ viewModel: Self) -> Void)? { get set }
}

