//
//  NavigationParameterDelegate.swift
//  BrandApp
//
//  Created by Bobson on 2016/4/14.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 * 可以被LoginFlowManager顯示的 UIViewController
 */
public protocol LoginFlowable: AnyObject {
    
    /**
     * 是否在登入流程中 (登入流程及一般頁面顯示有所不同時可供判斷)
     */
    var isLoginFlow: Bool { get set }
    
    /**
     * 是否隱藏 NavigationBar
     */
    var isNavigationBarHidden: Bool { get }
    
    /**
     * 是否隱藏 Back Button
     */
    var isHiddenBack: Bool { get }
}
