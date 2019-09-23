//
//  JSONResult.swift
//  XYJSON
//
//  Created by 蒋惠 on 2019/9/16.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

public protocol JSONResult {
    init()
    static func dealJSONResult(_ json: [String:Any]) -> [String:Any]
}

extension JSONResult {
    public static func dealJSONResult(_ json: [String:Any]) -> [String:Any] {
        var result = [String:Any]()
        let mirror = Mirror(reflecting: Self.init())
        for child in mirror.children {
            if let label = child.label {
                let resultKey: String
                let valueKey: String
                if let obj = child.value as? JSONPropertyProtocol {
                    resultKey = getJSONPropertyLabel(label)
                    valueKey = obj.name
                } else if child.value is JSONIgnoreProtocol {
                    resultKey = ""
                    valueKey = ""
                } else {
                    resultKey = label
                    valueKey = label
                }
                
                if !resultKey.isEmpty {
                    if let value = getValue(of: valueKey, json: json) {
                        result[resultKey] = value
                    }
                }
            }
        }
        return result
    }
}

extension JSONResult {
    private static func getJSONPropertyLabel(_ label: String) -> String {
        if label.hasPrefix("_") {
            var result = label
            result.remove(at: label.startIndex)
            return result
        } else {
            return label
        }
    }
    
    private static func getValue(of key: String, json: [String:Any]) -> Any? {
        if key.contains(".") {
            let list = key.components(separatedBy: ".")
            var json = json
            var result: Any? = nil
            for key in list {
                if let value = json[key] as? [String:Any] {
                    json = value
                } else {
                    result = json[key]
                }
            }
            return result
        } else if let value = json[key] {
            return value
        }
        return nil
    }
}
