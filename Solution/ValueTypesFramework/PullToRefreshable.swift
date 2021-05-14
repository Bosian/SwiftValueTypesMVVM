//
//  File.swift
//  Test
//
//  Created by 劉柏賢 on 2016/9/24.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

public protocol PullToRefreshable: AnyObject {
    
    var tableView: UITableView! { get }
    
    func setupPullToRefresh(selector: Selector, attributedTitle: NSAttributedString)
    func refresh(sender: UIRefreshControl)
}

extension PullToRefreshable
{
    public func setupPullToRefresh(selector: Selector, attributedTitle: NSAttributedString = NSAttributedString(string: ""))
    {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: selector, for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
    }
}
