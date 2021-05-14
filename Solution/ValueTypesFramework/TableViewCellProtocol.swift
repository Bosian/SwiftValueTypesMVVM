//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    var pageViewController: UIViewController? { get }
    var tableView: UITableView? { get }
}

extension TableViewCellProtocol where Self: UITableViewCell
{
    weak var pageViewController: UIViewController? {
        return self.tableView?.delegate as? UIViewController
    }
    
    weak var tableView: UITableView? {
        return self.superview?.superview as? UITableView
    }
}
