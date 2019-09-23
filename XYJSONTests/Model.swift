//
//  Model.swift
//  XYJSONTests
//
//  Created by Ray on 2019/9/23.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation
import XYJSON

enum Sex: Int, JSONValue {
    case girl = 0
    case boy
}

struct Employee: JSONParameters {
    @JSONProperty(name: "employee_name")
    var name: String
    var sex: Sex
    var age: Int
    var salary: Double
    @JSONIgnore()
    var other: String = ""
    var test: Test = Test()
    
    init(name: String,
         sex: Sex,
         age: Int,
         salary: Double) {
        self.sex = sex
        self.age = age
        self.salary = salary
        self.name = name
    }
}

struct Test: JSONValue, JSONParameters {
    
    var t1: Int = 1
    var t2: String = "t2"
    
    var jsonValue: JSONValue {
        // 可以返回基本数据类型 | 数组 | 字典
        return requestParameters
    }
}
