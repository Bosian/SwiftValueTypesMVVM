//
//  JsonDeserializeable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//



public protocol JsonDeserializeable {
    init(jsonDictionary: JsonDictionary)
    init(jsonString: String?)
    
    // 以下需struct各自實作
    init()
    mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
}

extension JsonDeserializeable
{
    public init(jsonDictionary: JsonDictionary)
    {
        #if DEBUG
            print("\r\nJson反序列化(jsonDictionary): \r\n\(jsonDictionary)")
        #endif
    
        self.init()
    
        jsonMapping(jsonDictionary)
        
        #if DEBUG
            print("\r\nJson反序列化(result): \r\n\(self)")
        #endif
    }
    
    public init(jsonString: String?)
    {
        self.init()
        
        guard let data = jsonString?.data(using: String.Encoding.utf8) else {
            return
        }
        
        do
        {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

            switch jsonObject {
            case let jsonDictionary as JsonDictionary:
                #if DEBUG
                    print("\r\n\r\nJson反序列化(jsonString): \r\n\(jsonDictionary)")
                #endif
                
                jsonMapping(jsonDictionary)
                
                #if DEBUG
                    print("\r\nJson反序列化(result): \r\n\(self)")
                #endif
                
            default:
                #if DEBUG
                    print("\r\nJson反序列化(未實作的Type): \r\n\(type(of: jsonObject))")
                #endif
            }
        }
        catch let error
        {
            #if DEBUG
                print("\r\nJson反序列化(catch error): \r\n\(error.localizedDescription)")
            #endif
        }
    }
}
