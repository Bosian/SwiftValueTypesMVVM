//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library
import PromiseKit

public protocol HttpPostWithMultiPartFormData: WebAPIProtocol
{
    /**
     * Content-Type: multipart/form-data
     */
    func multiPartFormData(_ parameter: TParameter) -> Promise<TResult>
}

extension HttpPostWithMultiPartFormData
{
    /**
     * 預設使用Post 及 FormData QueryString的方式
     */
    public func invokeAsync(_ parameter: TParameter) -> Promise<TResult>
    {
        return multiPartFormData(parameter)
    }
    
    /**
     * Content-Type: multipart/form-data
     */
    public func multiPartFormData(_ parameter: TParameter) -> Promise<TResult>
    {
        print("\r\n\r\nurl(\(type(of: self))): \(url.description)")
        
        let boundary = "AaB03x"
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        
        request.httpMethod = "POST"
        print("httpMethod: \(request.httpMethod ?? "")(HttpPostWithMultiPartFormData)")
        
        let MPboundary = "--\(boundary)"
        let endMPboundary = "\(MPboundary)--"
        
        // Http Body
        var bodyData = Data()
        var bodyString: String = ""
        
        let mirrorForModel = Mirror(reflecting: parameter)
        
        // 取得所有 Int, String 屬性
        for (label, value) in mirrorForModel.children
        {
            guard let value = Utilities.unwrap(value) else
            {
                continue
            }
            
            switch value
            {
                // 取得所有 Data 屬性
            case let value as Data:
                // set upload image, name is the key of image
                bodyData.append("\(MPboundary)\r\n".data(using: .utf8)!)
                bodyData.append("Content-Disposition: form-data; name=\"\(label!)\"; filename=\"\(label!).jpg\"\r\n".data(using: .utf8)!)
                bodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                
                bodyData.append(value)
                
                bodyData.append("\r\n".data(using: .utf8)!)
                
                
                // 取得所有 Data array屬性
            case let dataArray as [Data]:
                
                for (index, itemData) in dataArray.enumerated()
                {
                    // set upload image, name is the key of image
                    bodyData.append("\(MPboundary)\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Disposition: form-data; name=\"\(label!)\(index)\"; filename=\"\(label!)_\(index).jpg\"\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                    
                    bodyData.append(itemData)
                    
                    bodyData.append("\r\n".data(using: .utf8)!)
                }

            default:
                // with other params
                bodyString += "\(MPboundary)\r\n"
                bodyString += "Content-Disposition: form-data; name=\"\(label!)\"\r\n\r\n"
                bodyString += "\(value)\r\n"
            }
        }
        
        let end = "\(endMPboundary)"
        
        // 字串加入Data
        var body = Data()
        
        body.append(bodyString.data(using: .utf8)!)
        body.append(bodyData)
        body.append(end.data(using: .utf8)!)
        
        // Http Header
        request.addValue("\(body.count)", forHTTPHeaderField: HTTPHeader.contentLength.rawValue)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: HTTPHeader.contentType.rawValue)
        
        for (header, value) in WebConfig.shared.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        for (header, value) in parameter.httpHeader {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }
        
        print("httpHeader: \(request.allHTTPHeaderFields ?? [:])")
        
        request.httpBody = body
        
        print("httpBody(1/2):\(bodyString)\r\n")
        print("BodySize: \(body.count)")
        print("httpBody(完整):\(String(data: body, encoding: .utf8) ?? "")\r\n")
        
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
                            reject(WebAPIError<TResult>.fail(result))
                            return
                        }
                        
                        resolve(result)
                    } catch let error {
                        reject(error)
                    }
                })
                
                task.resume()
            })
        #endif
        
    }
}
