//
//  FontExtension.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/21.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import UIKit

/**
 * 修復 iOS 9 Bug: UIAlertController:supportedInterfaceOrientations was invoked recursively
 * http://stackoverflow.com/questions/31406820/uialertcontrollersupportedinterfaceorientations-was-invoked-recursively
 */
extension UIAlertController {
    
    public final override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    public final override var shouldAutorotate : Bool {
        return false
    }
}
