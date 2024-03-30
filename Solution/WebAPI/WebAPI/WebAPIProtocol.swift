//
//  ParserProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/30.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import Library

/**
 * WebAPI 基底類別
 */
public protocol WebAPIProtocol
{
    associatedtype TParameter: ParameterProtocol
    associatedtype TResult: ResponseModelProtocol
    associatedtype TParser: ParserProtocol
    
    var url: URL { get }
    var globalErrorConfig: WebAPIErrorConfig { get }
    
    @MainActor
    func invokeAsync(_ parameter: TParameter) async throws -> TResult
}
