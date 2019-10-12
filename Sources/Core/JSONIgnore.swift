//
//  JSONIgnore.swift
//  XYJSON
//
//  Created by RayJiang on 2019/9/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

protocol JSONIgnoreProtocol {
    
}

@propertyWrapper
public struct JSONIgnore<T: JSONValue>: JSONIgnoreProtocol {
    
    /// Value
    internal var value: T? = nil
    
    public init() {
        
    }
    
    public init(wrappedValue initialValue: T) {
        wrappedValue = initialValue
    }
    
    public var wrappedValue: T {
        get {
            guard let value = value else {
                fatalError("Uninitialized object")
            }
            return value
        } set {
            value = newValue
        }
    }
}
