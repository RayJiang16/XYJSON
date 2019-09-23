//
//  XYJSONTests.swift
//  XYJSONTests
//
//  Created by RayJiang on 2019/9/13.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import XCTest
import XYJSON

class XYJSONTests: XCTestCase {

    func testParameters() {
        let employee = Employee(name: "Tom", sex: .boy, age: 21, salary: 8000)
        let parameters = employee.requestParameters
        print(parameters)
        // ["employee_name": "Tom", "sex": 1, "age": 21, "salary": 8000.0, "test": ["t1": 1, "t2": "t2"]]
    }

}
