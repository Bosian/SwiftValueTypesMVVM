//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library
import PromiseKit

public protocol HttpPost: WebAPIProtocol
{
    /// Http Post
    ///
    /// - Parameter parameter: parameter description
    /// - Returns: return value description
    func post(_ parameter: TParameter) -> Promise<TResult>
}

extension HttpPost
{
    public func invokeAsync(_ parameter: TParameter) -> Promise<TResult>
    {
        return post(parameter)
    }
    
    /// Http Post
    public func post(_ parameter: TParameter) -> Promise<TResult>
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
            return Promise<TResult>(resolvers: { (resolve, reject) in
                DispatchQueue.global().async {
                    let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
                    print("http statusCode: \(response?.statusCode ?? -1)")
                    
                    do {
                        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
                        var result = try TParser().parse(self.url, data: nil, response: response, error: nil) as! TResult
                        result.response = response
                        resolve(result)
                    } catch let error {
                        reject(error)
                    }
                }
            })
        #else
            return Promise<TResult>(resolvers: { (resolve, reject) in
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    
                    let response = response as? HTTPURLResponse
                    print("http statusCode: \(response?.statusCode ?? -1)")
                    
                    
                    do {
                        
                        var result = try TParser().parse(self.url, data: data, response: response, error: error) as! TResult
                        result.response = response
                        
                        guard result.isSuccess else {
                            throw WebAPIError<TResult>.fail(result)
                        }
                        
                        resolve(result)
                        
                    } catch let error {
                        
                        reject(error)
                        
                        // 是否在發生錯誤時，在最後呼叫共用的全域錯誤處理
                        guard self.globalErrorConfig.isEnable else {
                            return
                        }
                        
                        self.globalErrorConfig.callbackDelegate?.failCallback(error, alertHandler: self.globalErrorConfig.alertHandler)
                    }
                })
                
                task.resume()
            })
        #endif
    }
}
