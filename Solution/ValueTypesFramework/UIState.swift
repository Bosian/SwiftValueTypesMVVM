//
//  UIState.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/8/31.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit
import Library

public enum UIState<TValue: Equatable, TStatus>: ValueRepresentable, Equatable {
    case normal(value: TValue)
    case success(value: TValue, message: String, duration: Double, completion: (() -> Bool)?, info: TStatus)
    case error(value: TValue, message: String, duration: Double, completion: (() -> Bool)?, info: TStatus)
    
    public typealias ValueType = TValue
    public var value: ValueType {
        
        switch self {
        case .normal(value: let value):
            return value
            
        case .success(value: let value, message: _, duration: _, completion: _, info: _):
            return value
            
        case .error(value: let value, message: _, duration: _, completion: _, info: _):
            return value
        }
    }
    
    public var message: String {
        
        switch self {
        case .normal(value: _):
            return ""
            
        case .success(value: _, message: let message, duration: _, completion: _, info: _):
            return message
            
        case .error(value: _, message: let message, duration: _, completion: _, info: _):
            return message
            
        }
    }
    
    public var content: (value: TValue, message: String, duration: Double, completion: (() -> Bool)?) {
        
        switch self {
        case .normal(value: let value):
            return (value: value, message: "", duration: 0, completion: nil)
            
        case .success(value: let value, message: let message, duration: let duration, completion: let completion, info: _):
            return (value: value, message: message, duration: duration, completion: completion)
            
        case .error(value: let value, message: let message, duration: let duration, completion: let completion, info: _):
            return (value: value, message: message, duration: duration, completion)
            
        }
    }
    
    public static func ==(lhs: UIState<TValue, TStatus>, rhs: UIState<TValue, TStatus>) -> Bool {
        
        switch lhs {
        case .normal(value: let lhsValue):
            
            switch rhs {
            case .normal(value: let rhsValue):
                return lhsValue == rhsValue
            
            default:
                return false
            }
        
        case .success(value: let lhsValue, message: let lhsMessage, duration: let lhsDuration, completion: _, info: _):
            
            switch rhs {
            case .success(value: let rhsValue, message: let rhsMessage, duration: let rhsDuration, completion: _, info: _):
                return lhsValue == rhsValue && lhsMessage == rhsMessage && lhsDuration == rhsDuration
                
            default:
                return false
            }
        
            
        case .error(value: let lhsValue, message: let lhsMessage, duration: let lhsDuration, completion: _, info: _):
            
            switch rhs {
            case .error(value: let rhsValue, message: let rhsMessage, duration: let rhsDuration, completion: _, info: _):
                return lhsValue == rhsValue && lhsMessage == rhsMessage && lhsDuration == rhsDuration
                
            default:
                return false
            }
            
        }
    }
}
