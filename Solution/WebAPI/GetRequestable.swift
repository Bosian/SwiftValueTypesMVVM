//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

public protocol GetRequestable: WebAPIProtocol
{
    /**
     * 取得自己的Request
     */
    func getRequest(parameter: TParameter) -> URLSession
}

extension GetRequestable
{
    /**
     * 取得自己的Request
     */
    public func getRequest(parameter: TParameter) -> URLRequest
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "POST"
        print("httpMethod: \(request.httpMethod ?? "")(GetRequestable)")
        
        // Http Header
        for (header, value) in WebConfig.shared.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        for (header, value) in parameter.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        print("httpHeader: \(request.allHTTPHeaderFields ?? [:])")
        
        // Http Body
        let httpBody = parameter.httpBody
        if !httpBody.isEmpty
        {
            print("httpBody: \(httpBody)")
            
            request.httpBody = httpBody.data(using: .utf8)
        }
        
        return request
    }
}
