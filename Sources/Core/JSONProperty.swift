//
//  JSONProperty.swift
//  XYJSON
//
//  Created by RayJiang on 2019/9/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

protocol JSONPropertyProtocol {
    var name: String { get }
    var value: Any { get }
}

@propertyWrapper
public struct JSONProperty<T: JSONValue>: JSONPropertyProtocol, JSONPropertyConvertProtocol {
    
    /// Key name
    public var name: String
    /// Value
    public var value: Any {
        guard let value = _value?.jsonValue else {
            fatalError("Uninitialized object: \(name)")
        }
        return value
    }
    
    internal var _value: T? = nil
    internal var convert: ((Any) -> Any)? = nil
    
    public init(name: String = "", convert: ((T) -> Any)? = nil) {
        self.name = name
        if let convert = convert {
            self.convert = { obj in
                if let obj = obj as? T {
                    return convert(obj)
                }
                return obj
            }
        }
    }
    
    public init(wrappedValue initialValue: T, name: String = "", convert: ((T) -> Any)? = nil) {
        self.init(name: name, convert: convert)
        wrappedValue = initialValue
    }
    
    public var wrappedValue: T {
        get {
            guard let _value = _value else {
                fatalError("Uninitialized object: \(name)")
            }
            return _value
        } set {
            _value = newValue
        }
    }
}
