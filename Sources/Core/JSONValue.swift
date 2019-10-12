//
//  JSONValue.swift
//  XYJSON
//
//  Created by RayJiang on 2019/9/12.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

public protocol JSONValue {
    var jsonValue: JSONValue { get }
}

extension Bool: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Int: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Float: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Double: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension String: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Dictionary: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Array: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension JSONValue where Self: RawRepresentable, RawValue: JSONValue {
    public var jsonValue: JSONValue {
        return rawValue
    }
}


extension Int8: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Int16: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Int32: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension Int64: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension UInt: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension UInt8: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension UInt16: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension UInt32: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}

extension UInt64: JSONValue {
    public var jsonValue: JSONValue {
        return self
    }
}
