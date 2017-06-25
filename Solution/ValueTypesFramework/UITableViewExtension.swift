//
//  UITableViewExtension.swift
//  ValueTypesFramework
//
//  Created by Bobson on 2017/1/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 避免Reload後，鍵盤Next失效、回彈的靈異問題
    ///
    /// - Parameter isSaveContentOffset: 是否保留ContentOfset
    public func reloadData(isSaveContentOffset: Bool) {
        
        guard isSaveContentOffset else {
            self.reloadData()
            return
        }
        
        // 避免Reload後回彈問題
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutSubviews()
        self.contentOffset = contentOffset
    }
    
}
