//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 *  CellViewModel UISwitch isOn 變更
 */
public protocol SwitchChangeable
{
    var index: Int { get set }
    var isSelected: Bool { get set }
    var switchChangeHandler: ((_ index: Int, _ info: Bool, _ viewModel: Self) -> Void)? { get set }
}
