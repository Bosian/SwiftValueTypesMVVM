//
//  ParameterProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/22.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import Library

public protocol ParameterProtocol
{
    /// Http header
    var httpHeader: [HTTPHeader: String] { get }
    
    /// Http body QueryString or json string
    var httpBody: String { get }
}

extension ParameterProtocol
{
    /// Http header
    public var httpHeader: [HTTPHeader: String] {
        return [:]
    }
    
    /// Http body QueryString or json string
    public var httpBody: String
    {
        var allMirrors: [Mirror] = []
        getAllMirrors(mirror: Mirror(reflecting: self), allMirrors: &allMirrors)
        
        var str: String = ""
        for mirror in allMirrors {
            str += getQueryString(mirror)
        }
        
        // 移除最後一個'&'
        return String(str.dropLast())
    }
    
    /// SuperClass ParameterProtocol property
    ///
    /// - Parameter mirror: current class or struct mirror description
    /// - Returns: return value description
    private func getAllMirrors(mirror: Mirror, allMirrors: inout [Mirror]) {
        
        allMirrors.append(mirror)
        
        guard let superMirror = mirror.superclassMirror else {
            return
        }
        
        getAllMirrors(mirror: superMirror, allMirrors: &allMirrors)
    }
    
    /**
     取得QueryString
     
     - parameter mirror: 物件的Mirror Type
     
     - returns: QueryString
     */
    private func getQueryString(_ mirror: Mirror) -> String
    {
        var str: String = ""
        
        let converter = self as? PropertyConverters
        var propertyConverters = converter?.propertyConverters() ?? []
        
        let propertyMapper = self as? PropertyMapping
        var propertyMappings = propertyMapper?.propertyMapping() ?? []
        
        for child in mirror.children
        {
            // 該屬性是否為nil
            guard let value = Utilities.unwrap(child.value) else {
                continue
            }
            
            guard let propertyName = child.label else {
                continue
            }
            
            let outputKey = getOutputKey(propertyName, propertyMappings: &propertyMappings)
            guard let outputValue = getOutputValue(propertyName, value: value, converters: &propertyConverters) else {
                continue
            }
            
            // string array
            switch outputValue {
            case let value as String:
                let stringValue = value.replacingOccurrences(of: " ", with: "%20")
                
                // 將轉換後的Value組 QueryString
                str += "\(outputKey)=\(stringValue)&"
                
            case let array as [String]:
                
                let arrayKey = "\(outputKey)[]"
                let arrayQueryString = array.map { "\(arrayKey)=\($0)&" }.joined()
                
                str += arrayQueryString
                
            default:
                // 將轉換後的Value組 QueryString
                str += "\(outputKey)=\(outputValue)&"
            }
        }
        
        return str
    }
    
    /**
     取得QueryString的 Key
     
     - parameter propertyName:     屬性名稱
     - parameter propertyMappings: propertyMappings description
     
     - returns: 轉換後的Key
     */
    private func getOutputKey(_ propertyName: String, propertyMappings: inout [(String?, String?)]) -> String
    {
        var outputKey: String = propertyName
        
        // 尋找該屬性是否有使用 propertyMapping
        let propertyMappingIndexWrapped = propertyMappings.firstIndex(where: { (parameter: (String?, String?)) -> Bool in
            return parameter.0 == propertyName
        })
        
        guard let propertyMappingIndex = propertyMappingIndexWrapped else
        {
            return propertyName
        }
        
        outputKey = propertyMappings[propertyMappingIndex].1 ?? propertyName
        propertyMappings.remove(at: propertyMappingIndex)
        
        return outputKey
    }
    
    /**
     取得QueryString的Value
     
     - parameter propertyName: 屬性名稱
     - parameter value:        屬性值
     - parameter converters:   converters description
     
     - returns: 轉換後的Value
     */
    private func getOutputValue(_ propertyName: String, value: Any, converters: inout [(String?, () -> Any?)]) -> Any?
    {
        // 尋找該屬性是否有使用 propertyConverter
        let indexWrapped = converters.firstIndex(where: { (parameter: (String?, () -> Any?)) -> Bool in
            return propertyName == parameter.0
        })
        
        // 該屬性是使用 propertyConverter
        guard let index = indexWrapped else
        {
            return value
        }
        
        let converter = converters[index]
        
        // 移除已Match的
        converters.remove(at: index)
        
        // 回傳轉換後的Value
        return converter.1()
    }
}
