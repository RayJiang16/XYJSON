//
//  JSONParameters.swift
//  XYJSON
//
//  Created by RayJiang on 2019/9/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

public protocol JSONParameters {
    var requestParameters: [String:Any] { get }
}

extension JSONParameters {
    public var requestParameters: [String:Any] {
        var parameters = [String:Any]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let obj = child.value as? JSONPropertyProtocol {
                let name: String
                if obj.name.isEmpty {
                    var label = (child.label ?? "")
                    label.remove(at: label.startIndex)
                    name = label
                } else {
                    name = obj.name
                }
                
                if let convertObj = child.value as? JSONPropertyConvertProtocol, let convert = convertObj.convert {
                    parameters[name] = convert(obj.value)
                } else {
                    parameters[name] = obj.value
                }
            } else if child.value is JSONIgnoreProtocol {
                
            } else {
                if let name = child.label {
                    if let value = child.value as? JSONValue {
                        parameters[name] = value.jsonValue
                    } else {
                        parameters[name] = child.value
                    }
                }
            }
        }
        return parameters
    }
}
