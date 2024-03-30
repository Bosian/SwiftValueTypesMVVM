//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library

public protocol HttpPostWithJson: WebAPIProtocol where TParameter: JsonSerializeable {
    
}

extension HttpPostWithJson
{
    public func invokeAsync(_ parameter: TParameter) async throws -> TResult
    {
        return try await postWithJson(parameter)
    }
    
    /**
     * Http Post with Raw Json
     */
    public func postWithJson(_ parameter: TParameter) async throws -> TResult
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "POST"
        print("httpMethod: \(request.httpMethod ?? "")(HttpPostWithJson)")
        
        // Http Header
        request.addValue("application/json", forHTTPHeaderField: HTTPHeader.contentType.rawValue)
        
        for (header, value) in WebConfig.shared.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        for (header, value) in parameter.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        print("httpHeader: \(request.allHTTPHeaderFields ?? [:])")
        
        // Http Body
        let httpBody = parameter.toJsonString()
        if !httpBody.isEmpty
        {
            print("httpBody: \(httpBody)")
            
            request.httpBody = httpBody.data(using: .utf8)
        }
        
#if FAKE
        do {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
            print("http statusCode: \(response?.statusCode ?? -1)")
            
            var result = try TParser().parse(self.url, data: nil, response: response, error: nil) as! TResult
            result.response = response
            return result
        } catch {
            throw error
        }
#else
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let urlRsponse = response as? HTTPURLResponse
            print("http statusCode: \(urlRsponse?.statusCode ?? -1)")
            
            var result = try TParser().parse(self.url, data: data, response: urlRsponse, error: nil) as! TResult
            result.response = urlRsponse
            
            guard result.isSuccess else {
                throw WebAPIError<TResult>.fail(result)
            }
            
            return result
        } catch {
            throw error
        }
#endif
    }
}
