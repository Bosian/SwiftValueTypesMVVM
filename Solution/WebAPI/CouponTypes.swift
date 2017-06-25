//
//  Model.swift
//  WebAPI
//
//  Created by Bobson on 2016/8/22.
//  Copyright © 2016年 Sonet. All rights reserved.
//


import Library

/**
 優惠券種類
 - productionTicket: 0: 商品兌換券
 - couponTicket:     1: 折扣券
 */
public enum CouponTypes: Int, StringConvertable
{
    case none = -1
    
    /**
     * 商品兌換卷
     */
    case productionTicket = 0
    
    /**
     * 折扣卷
     */
    case couponTicket = 1
}
