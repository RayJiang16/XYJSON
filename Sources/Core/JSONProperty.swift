//
//  JSONProperty.swift
//  XYJSON
//
//  Created by RayJiang on 2019/9/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

public protocol JSONPropertyProtocol {
    var name: String { get }
    var value: Any { get }
}

@propertyWrapper
public struct JSONProperty<T: JSONValue>: JSONPropertyProtocol {
    public var name: String
    public var _value: T? = nil
    public var value: Any {
        guard let value = _value?.jsonValue else {
            #if DEBUG
            fatalError("未初始化对象:\(name)")
            #else
            return ""
            #endif
        }
        return value
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public init(wrappedValue initialValue: T, name: String) {
        self.name = name
        wrappedValue = initialValue
    }
    
    public var wrappedValue: T {
        get {
            guard let _value = _value else {
                #if DEBUG
                fatalError("未初始化对象:\(name)")
                #else
                return ""
                #endif
            }
            return _value
        } set {
            _value = newValue
        }
    }
}
