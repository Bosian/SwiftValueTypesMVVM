//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library

public protocol HttpPost: WebAPIProtocol {
}

extension HttpPost
{
    public func invokeAsync(_ parameter: TParameter) async throws -> TResult
    {
        return try await post(parameter)
    }
    
    /// Http Post
    public func post(_ parameter: TParameter) async throws -> TResult
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "POST"
        print("httpMethod: \(request.httpMethod ?? "")(HttpPost)")
        
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
        print("httpBody: \(httpBody)")
        
        request.httpBody = httpBody.data(using: .utf8)
        
#if FAKE
        do {
            let urlResponse = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
            print("http statusCode: \(urlResponse?.statusCode ?? -1)")
            
            var result = try TParser().parse(self.url, data: nil, response: urlResponse, error: nil) as! TResult
            result.response = urlResponse
            return result
        } catch {
            throw error
        }
#else
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let urlResponse = response as? HTTPURLResponse
            print("http statusCode: \(urlResponse?.statusCode ?? -1)")
            
            var result = try TParser().parse(self.url, data: data, response: urlResponse, error: nil) as! TResult
            result.response = urlResponse
            
            guard result.isSuccess else {
                throw WebAPIError<TResult>.fail(result)
            }
            
            return result
            
        } catch {
            
            // 是否在發生錯誤時，呼叫共用的全域錯誤處理
            if globalErrorConfig.isEnable {
                globalErrorConfig.callbackDelegate?.failCallback(error, alertHandler: globalErrorConfig.alertHandler)
            }
            
            throw error
        }
#endif
    }
}
