//
//  NavigationParameterDelegate.swift
//  BrandApp
//
//  Created by Bobson on 2016/4/14.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 * 參數傳遞 
 */
public protocol ParameterDelegate
{
    func getParameter() -> Any?
    func setParameter(_ parameter: Any?)
}
