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
public protocol TextFieldChangeable
{
    var index: Int { get set }
    var textFieldChangeHandler: ((_ index: Int, _ info: String?, _ viewModel: Self) -> Self)? { get set }
}
