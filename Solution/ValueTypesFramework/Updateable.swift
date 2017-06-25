//
//  Updateable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol Updateable {
    var isUpdate: UIState<Bool, String> { get set }
}
