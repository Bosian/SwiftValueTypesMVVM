//
//  ParserProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/30.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import Library

public protocol JsonParser: ParserProtocol
{
    associatedtype TResult: JsonDeserializeable
    
    func parseJson(_ url: URL, data: Data?, response: URLResponse?, error: Error?) throws -> TResult
}

extension JsonParser
{
    /**
     * 部析 URLSession 回傳的資料
     */
    public func parse(_ url: URL, data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) throws -> TResult
    {
        return try parseJson(url, data: data, response: response, error: error)
    }
    
    public func parseJson(_ url: URL, data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) throws -> TResult
    {
        if let error = error
        {
            throw error
        }
        
        guard let data = data else
        {
            #if FAKE
                let fakeMode = "(Fake Mode)"
            #else
                let fakeMode = ""
            #endif
            
            print("\(fakeMode) \(url.description) is return nil from Server!\r\n\r\n")
            
            throw WebAPIError<TResult>.dataIsNil
        }
        
        guard let jsonString = String(data: data, encoding: .utf8) else
        {
            print("\(url.description) data to string fail! \r\n\r\n")
            throw WebAPIError<TResult>.dataCannotConvertToString
        }
        
        #if DEBUG
            debugPrint(url: url, data: data, jsonString: jsonString)
        #endif
        
        return TResult.init(jsonString: jsonString)
    }
    
    #if DEBUG
    public func debugPrint(url: URL, data: Data, jsonString: String)
    {
        let transform = "Any-Hex/Java" as CFString!
        let convertedString = jsonString.mutableCopy() as! NSMutableString
        CFStringTransform(convertedString, nil, transform, true)
        
        #if FAKE
            let fakeMode = "(Fake Mode)"
        #else
            let fakeMode = ""
        #endif
        
        print("\r\n\r\nresult url(\(type(of: self))): \(fakeMode) \(url.absoluteString)")
        print("result raw: \(convertedString.replacingOccurrences(of: "\\/", with: "/"))\r\n\r\n")
        
        do{
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary else {
                return
            }
            
            guard let convertedString = "\(dictionary)".mutableCopy() as? NSMutableString else {
                return
            }
            
            CFStringTransform(convertedString, nil, transform, true)
        }
        catch let errorType
        {
            print("Json Parse 有錯誤: \(errorType.localizedDescription) \r\n\r\n")
        }
    }
    #endif
}
