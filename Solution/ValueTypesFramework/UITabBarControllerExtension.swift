//
//  UINavigationExtendsion.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/30.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import UIKit

extension UITabBarController
{
    open override func viewDidLoad() {
        
        // Set StatusBar Style
        self.tabBar.barStyle = .default
        self.tabBar.barTintColor = UIColor(r: 248, g: 248, b: 248)
        self.tabBar.tintColor = UIColor(r: 38, g: 190, b: 201)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let titleAttribute: [String: Any] = [
            NSFontAttributeName: UIFont(name: "PingFang TC", size: 10)!
        ]
        
        for item in items
        {
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.setTitleTextAttributes(titleAttribute, for: .normal)
            item.titlePositionAdjustment = .init(horizontal: 0, vertical: -2)
        }
    }
    
    open override var shouldAutorotate : Bool {
        return self.selectedViewController!.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        
        guard let viewController = self.selectedViewController else
        {
            return .portrait
        }
        
        if let innserNavigationController = viewController as? UINavigationController
        {
            return innserNavigationController.visibleViewController?.supportedInterfaceOrientations ?? []
        }
        else
        {
            return viewController.supportedInterfaceOrientations
        }
    }
    
    open override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return self.selectedViewController!.preferredInterfaceOrientationForPresentation
    }
    
}
