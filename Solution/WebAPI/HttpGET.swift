//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library

public protocol HttpGet: WebAPIProtocol {
    
}

extension HttpGet
{
    public func invokeAsync(_ parameter: TParameter) async throws -> TResult
    {
        return try await get(parameter)
    }
    
    /// Http GET
    public func get(_ parameter: TParameter) async throws -> TResult
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            print("\r\n\r\nurlComponentsError: \(url.description)")
            
            throw WebAPIError<TResult>.invalidUrl(url: url)
        }
        
        // Http Body
        let httpBody = parameter.httpBody
        if !httpBody.isEmpty
        {
            print("httpBody: \(httpBody)")
            
            urlComponents.query = httpBody
        }
        
        guard let url = urlComponents.url else {
            
            print("\r\n\r\nurlError: \(self.url.description)")
            
            throw WebAPIError<TResult>.invalidUrl(url: self.url)
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "GET"
        print("httpMethod: \(request.httpMethod ?? "")(HttpGet)")
        
        // Http Header
        for (header, value) in WebConfig.shared.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        for (header, value) in parameter.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        print("httpHeader: \(request.allHTTPHeaderFields ?? [:])")
        
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
            throw error
        }
#endif
    }
}
