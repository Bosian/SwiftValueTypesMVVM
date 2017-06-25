//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol GoogleAnalyzer
{
    /**
     * Google 分析 傳送所在畫面分析
     */
    func sendScreenTrack(_ screenName: String)
    
    /**
     * [事件使用] Google 分析
     */
    func googleAnalyticsEvent(_ label: String)
}
