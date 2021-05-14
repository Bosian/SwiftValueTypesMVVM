//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 *  回首頁
 */
public protocol BackHandler: AnyObject {
    
    var backTitle: String { get set }
    
    /**
     回首頁
     */
    func goHome()
}

// MARK: - 回首頁
extension BackHandler where Self: UIViewController
{
    /**
     * NavigationItem Back 文字
     */
    public var backTitle: String {
        get {
            return self.navigationItem.backBarButtonItem?.title ?? ""
        }
        
        set {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: newValue, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
    }
    
    /**
     回首頁
     */
    public func goHome()
    {
        if let navigationController = self.navigationController
        {
            navigationController.popToRootViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: { [weak self] () -> Void in
                _ = self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
}
