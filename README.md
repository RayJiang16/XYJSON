# XYJSON

An easy way to create parameters of request.

[中文介绍](README_CN.md)



## Requirements

- iOS 8.0+
- Swift 5.1+
- Xcode 11.0+



## Installation

**Installation with [CocoaPods](https://cocoapods.org/):**

```
pod 'XYJSON'
```
**Installation with [Carthage](https://github.com/Carthage/Carthage):**
```
github "RayJiang16/XYJSON"
```



## Usage

### JSONParameters

Struct or Class conform to `JSONParameters`, you can use `requestParameters` for free.

```swift
struct Employee: JSONParameters {
    var name: String
    var age: Int
}

let employee = Employee(name: "Tom", age: 21)
print(employee.requestParameters)
// {"name":"Tom", "age":21}
```



### JSONProperty

The property name in your model (`name` in this case), might not same name in request. You can use `@JSONProperty` to rename that.

```swift
struct Employee: JSONParameters {
    @JSONProperty(name: "employee_name")
    var name: String
    var age: Int
}

let employee = Employee(name: "Tom", age: 21)
print(employee.requestParameters)
// {"employee_name":"Tom", "age":21}
```



### JSONIgnore

You can use `@JSONIgnore` to ignore the property that you don't want it in request parameters.

```swift
struct Employee: JSONParameters {
    @JSONProperty(name: "employee_name")
    var name: String
    var age: Int
    @JSONIgnore()
    var other: String = ""
}

let employee = Employee(name: "Tom", age: 21)
print(employee.requestParameters)
// {"employee_name":"Tom", "age":21}
```



### JSONValue

#### Enum

If you want to use enum in your model, you need to make the enum conform to `JSONValue`.

```swift
enum Sex: Int, JSONValue {
    case girl = 0
    case boy
}
struct Employee: JSONParameters {
    var name: String
    var sex: Sex
}

let employee = Employee(name: "Tom", sex: .boy)
print(employee.requestParameters)
// {"name":"Tom", "sex":1}
```

#### Custom model

if you want to use another struct or class in your model, you need to make the model conform to `JSONValue` and implement `var jsonValue: JSONValue`.

```swift
enum Sex: Int, JSONValue {
    case girl = 0
    case boy
}
struct Employee: JSONParameters {
    var name: String
    var sex: Sex
    var test: Test = Test()
}
struct Test: JSONValue, JSONParameters {
    var t1: Int = 1
    var t2: String = "t2"
    var jsonValue: JSONValue {
        // You can return Int, Double, Array, Dictionary...
        return requestParameters
    }
}

let employee = Employee(name: "Tom", sex: .boy)
print(employee.requestParameters)
// {"name":"Tom", "sex":1, "test":{"t1":1, "t2":"t2"}}
```



## Note

You need to rewrite `init` function when you use `@JSONProperty` or `@JSONIgnore`. The default `init` function dosen't work, because `@propertyWrapper` is **struct** in real.

In the `init` function, you should set property which is `@JSONProperty` or `@JSONIgnore` in the last if you don't set the default value of the property in your model.

```swift
struct Employee: JSONParameters {
    @JSONProperty(name: "employee_name")
    var name: String
    var age: Int
    
    init(name: String,
         age: Int) {
        self.age = age
        self.name = name
    }
}
```

**DO NOT** use `XYJSON` and `HandyJSON` in one model, otherwise `HandyJSON` dosen't work. Because `@propertyWrapper` is **struct** in real.



## License

**XYJSON** is under MIT license. See the [LICENSE](LICENSE) file for more info.
