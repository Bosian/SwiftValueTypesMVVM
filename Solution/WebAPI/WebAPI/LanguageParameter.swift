//
//  ParameterProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/22.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import Library

public protocol LanguageParameter: PropertyConverters, PropertyMapping
{
    /// 裝置目前語系
    var language: Language { get }
}

extension LanguageParameter
{
    public func propertyConverters() -> [(String?, () -> Any?)] {
        return languagePropertyConverters()
    }
    
    public func languagePropertyConverters() -> [(String?, () -> Any?)]
    {
        return [
            (
                "language",
                { () -> Any? in
                    return self.language.rawValue
                }
            )
        ]
    }
    
    public func propertyMapping() -> [(String?, String?)] {
        return languagePropertyMapping()
    }
    
    public func languagePropertyMapping() -> [(String?, String?)] {
        return [
            ("language", "lang")
        ]
    }
}

