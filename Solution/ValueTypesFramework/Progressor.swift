//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol Progressor: AnyObject {
    
    /**
     顯示更新中
     */
    func showProgress(_ viewModel: Updateable)
    
    /**
     顯示網路資料更新中
     */
    func showNetworkProgress(_ viewModel: Updateable)
}

extension Progressor where Self: UIViewController
{
    /**
     顯示網路資料更新中
     
     - parameter isUpdate: isUpdate description
     */
    public func showNetworkProgress(_ viewModel: Updateable)
    {
        // StatusBar上的網路圖示動畫
        UIApplication.shared.isNetworkActivityIndicatorVisible = viewModel.isUpdate.value
    }
}
