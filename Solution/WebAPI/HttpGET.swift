//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library
import PromiseKit

public protocol HttpGet: WebAPIProtocol
{
    /// Get
    ///
    /// - Parameter parameter: parameter description
    /// - Returns: return value description
    func get(_ parameter: TParameter) -> Promise<TResult>
}

extension HttpGet
{
    public func invokeAsync(_ parameter: TParameter) -> Promise<TResult>
    {
        return get(parameter)
    }
    
    /// Http GET
    public func get(_ parameter: TParameter) -> Promise<TResult>
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            print("\r\n\r\nurlComponentsError: \(url.description)")
            
            return Promise<TResult>(error: WebAPIError<TResult>.invalidUrl(url: url))
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
            
            return Promise<TResult>(error: WebAPIError<TResult>.invalidUrl(url: self.url))
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
            return Promise<TResult>(resolver: { (resolver) in
                DispatchQueue.global().async {
                    
                    let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
                    print("http statusCode: \(response?.statusCode ?? -1)")
                    
                    do {
                        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
                        var result = try TParser().parse(self.url, data: nil, response: response, error: nil) as! TResult
                        result.response = response
                        resolver.fulfill(result)
                    } catch let error {
                        resolver.reject(error)
                    }
                }
            })
        #else
            return Promise<TResult>(resolver: { (resolver) in
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    
                    let response = response as? HTTPURLResponse
                    print("http statusCode: \(response?.statusCode ?? -1)")
                    
                    do {
                        var result = try TParser().parse(self.url, data: data, response: response, error: error) as! TResult
                        result.response = response
                        
                        guard result.isSuccess else {
                            resolver.reject(WebAPIError<TResult>.fail(result))
                            return
                        }
                        
                        resolver.fulfill(result)
                    } catch let error {
                        resolver.reject(error)
                    }
                })
                
                task.resume()
            })
        #endif
    }
}
