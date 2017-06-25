//
//  ParserProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/30.
//  Copyright © 2015年 Bobson. All rights reserved.
//

/**
 * Parse Json dictionary to Model
 */
public protocol ParserProtocol
{
    associatedtype TResult
    
    init()
    
    /**
     * 部析 URLSession 回傳的資料
     */
    func parse(_ url: URL, data: Data?, response: URLResponse?, error: Error?) throws -> TResult
}
