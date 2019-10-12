//
//  JSONPropertyConvert.swift
//  XYJSON
//
//  Created by RayJiang on 2019/10/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

protocol JSONPropertyConvertProtocol {
    var convert: ((Any) -> Any)? { get }
}

/// Bool ? 1 : 0
public let convertBoolToInt: ((Bool) -> Int) = { b in
    return b ? 1 : 0
}

/// Bool ? "1" : "0"
public let convertBoolToIntString: ((Bool) -> String) = { b in
    return b ? "1" : "0"
}

/// String(Int)
public let convertIntToString: ((Int) -> String) = { n in
    return String(n)
}

/// Return 0 if failed to convert string to int.
public let convertStringToInt: ((String) -> Int) = { s in
    return Int(s) ?? 0
}

/// String(Double)
public let convertDoubleToString: ((Double) -> String) = { d in
    return String(d)
}
