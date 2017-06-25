//
//  UINavigationExtendsion.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/30.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import UIKit
import Library

extension UINavigationController
{
    open override func viewDidLoad() {
        
        // Set StatusBar Style
        self.navigationBar.barStyle = .default
        
        // 背景色
//        self.navigationBar.barTintColor = UIColor.white

        // 按鈕頻色
//        self.navigationBar.tintColor = UIColor(r: 148, g: 31, b: 150)

        // 字體頻色
//        self.navigationBar.titleTextAttributes = [
//            NSForegroundColorAttributeName: UIColor.init(hexString: "#990099")!
//        ]
    }
    
    /**
     * 更換NavigationController 的Root
     */
    public func replaceRootNavigationController(_ storyboardName: String, controllerType: UIViewController.Type)
    {
        let navigationController = self
        let className = "\(controllerType)"
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: className)
        var viewControllers = navigationController.viewControllers
        
        viewControllers[0] = rootViewController
        
        navigationController.setViewControllers(viewControllers, animated: false)
    }
    
    open override var shouldAutorotate : Bool {
        return self.visibleViewController?.shouldAutorotate ?? false
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        
        guard let viewController = self.visibleViewController else
        {
            return .portrait
        }
        
        if let innserNavigationController = viewController as? UINavigationController
        {
            return innserNavigationController.visibleViewController!.supportedInterfaceOrientations
        }
        else
        {
            return viewController.supportedInterfaceOrientations
        }
    }
    
    open override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return self.visibleViewController!.preferredInterfaceOrientationForPresentation
    }
}
