//
//  HttpGET.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/8/6.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import Library

public protocol HttpPostWithMultiPartFormData: WebAPIProtocol {
}

extension HttpPostWithMultiPartFormData
{
    /**
     * 預設使用Post 及 FormData QueryString的方式
     */
    public func invokeAsync(_ parameter: TParameter) async throws -> TResult
    {
        return try await multiPartFormData(parameter)
    }
    
    /**
     * Content-Type: multipart/form-data
     */
    public func multiPartFormData(_ parameter: TParameter) async throws -> TResult
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
            guard let label,
                  let value = Utilities.unwrap(value) else
            {
                continue
            }
            
            switch value
            {
                    // 取得所有 Data 屬性
                case let value as Data:
                    // set upload image, name is the key of image
                    bodyData.append("\(MPboundary)\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Disposition: form-data; name=\"\(label)\"; filename=\"\(label).jpg\"\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                    
                    bodyData.append(value)
                    
                    bodyData.append("\r\n".data(using: .utf8)!)
                    
                    
                    // 取得所有 Data array屬性
                case let dataArray as [Data]:
                    
                    for (index, itemData) in dataArray.enumerated()
                    {
                        // set upload image, name is the key of image
                        bodyData.append("\(MPboundary)\r\n".data(using: .utf8)!)
                        bodyData.append("Content-Disposition: form-data; name=\"\(label)\(index)\"; filename=\"\(label)_\(index).jpg\"\r\n".data(using: .utf8)!)
                        bodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                        
                        bodyData.append(itemData)
                        
                        bodyData.append("\r\n".data(using: .utf8)!)
                    }
                    
                default:
                    // with other params
                    bodyString += "\(MPboundary)\r\n"
                    bodyString += "Content-Disposition: form-data; name=\"\(label)\"\r\n\r\n"
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
        do {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
            print("http statusCode: \(response?.statusCode ?? -1)")
            
            let urlResponse = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: "", headerFields: nil)
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
