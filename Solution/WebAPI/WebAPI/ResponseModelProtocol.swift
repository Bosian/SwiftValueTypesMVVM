//
//  ResponseModelProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/23.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import Library

public protocol ResponseModelProtocol
{
    var response: HTTPURLResponse? { get set }
    
    var metadata: Metadata { get set }
    
    // ====== App custom =========
    
    /// metadata.status is 200
    var isSuccess: Bool { get }
}

extension ResponseModelProtocol {

    // ====== App custom =========
    
    //// metadata.status is 200
    public var isSuccess: Bool {
        return response?.statusCode == 200
    }
    
    /// 錯誤狀態
    public var status: ErrorStatus {
        switch metadata.status {
        default:
            return .none
        }
    }
}

/// 錯誤狀態
///
public enum ErrorStatus {
    case none
}

public struct Metadata: JsonDeserializeable {
    
    public var pagination: Pagination?
    public var status: String = ""
    public var desc: [String] = []
    
    public init()
    {
        
    }
    
    public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
    {
        self.pagination = Pagination(jsonDictionary: jsonDictionary["pagination"] as? JsonDictionary ?? JsonDictionary())
        self.status = jsonDictionary["status"].stringOrDefault
        
        let descValue = jsonDictionary["desc"]
        self.desc = descValue.stringArray ?? [descValue.stringOrDefault]
    }
}

public struct Pagination: JsonDeserializeable {
    
    public var start: Int = -1
    public var total_count: Int = -1
    public var count: Int = -1
    
    public init()
    {
        
    }
    
    public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
    {
        self.start = jsonDictionary["start"].int ?? -1
        self.total_count = jsonDictionary["total_count"].int ?? -1
        self.count = jsonDictionary["count"].int ?? -1
    }
}
