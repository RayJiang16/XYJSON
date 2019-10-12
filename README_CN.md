# XYJSON

一个便捷创建 request 中参数的框架。



## 要求

- iOS 8.0+
- Swift 5.1+
- Xcode 11.0+



## 安装

**[CocoaPods](https://cocoapods.org/):**

```
pod 'XYJSON'
```
**[Carthage](https://github.com/Carthage/Carthage):**

```
github "RayJiang16/XYJSON"
```



## 使用

### JSONParameters

当 Struct 或 Class 遵守 `JSONParameters` 协议之后，就能用 `requestParameters` 属性获取 JSON 字典了，默认情况下会把 Model 中所有的字段都取出来。

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

实际开发中，Model 中的字段名可能会和接口中的字段名不一样。这个时候就要使用 `@JSONProperty` 来重命名了，重命名之后项目中还是用 `name`， `requestParameters` 获取到的字段就会变成 `employee_name` 了。

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

另外还有一种情况，一个 bool 类型的字段，但是在接口传输的时候用 int 来表示，这个时候就要使用 `@JSONProperty` 中的 convert 属性了。

```swift
struct TestConvert: JSONParameters {
    @JSONProperty(convert: convertIntToString)
    var id: Int
    @JSONProperty(name: "is_vip", convert: convertBoolToInt)
    var isVip: Bool
    @JSONProperty(convert: { obj in
        return obj ? "Yes" : "No"
    })
    var custom: Bool
}

let obj = TestConvert(id: 233, isVip: true, custom: false)
print(obj.requestParameters)
// {"id": "233", "is_vip": 1, "custom": "No"}
```

convert 是一个闭包 `(T) -> Any` T 是属性的类型，`XYJSON` 提供了几个常见的 convert：

- convertBoolToInt
- convertBoolToIntString
- convertIntToString
- convertStringToInt
- convertDoubleToString

如果默认的 convert 不满足你的需求，可以自定义 convert。



### JSONIgnore

还有一个很常见的情况，这个 Model 可能增加了一些仅在本地使用的属性，不需要出现在接口中。这个时候就可以用 `@JSONIgnore` 把这个字段过滤掉。

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

如果 Model 中使用了枚举，并且想要把枚举的 `rawValue` 传过去，那么只需要让枚举遵守 `JSONValue` 协议就可以了。

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

如果 Model 中嵌套了另一个 Model，需要让另一个 Model 遵守 `JSONValue` 协议，并实现 `var jsonValue: JSONValue` 属性，这个属性要求返回基本数据类型，数组或字典。

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
        // 可以返回基本数据类型 | 数组 | 字典
        return requestParameters
    }
}

let employee = Employee(name: "Tom", sex: .boy)
print(employee.requestParameters)
// {"name":"Tom", "sex":1, "test":{"t1":1, "t2":"t2"}}
```



## 注意事项

如果在 Model 中使用了 `@JSONProperty` 或 `@JSONIgnore`，你需要重写 `init` 方法，因为属性包裹器（`@propertyWrapper`）的本质是 **struct**，所以默认的初始化方法将无法使用。

另外如果 Model 中的属性没有默认值的话，在 `init` 方法中你必须将 `@JSONProperty` 或 `@JSONIgnore` 的属性放在最后设置。

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

请不要在一个 Model 里同时使用 `XYJSON` 和 `HandyJSON`，否则 `HandyJSON` 将失效，因为属性包裹器的本质是 **struct**， `HandyJSON` 会映射失败。



最后，这个框架只能用于 request 无法用于 response，如果要支持 response 相当于做一个类似 `HandyJSON` 的框架了...



## 协议

**XYJSON** 基于 MIT 协议进行分发和使用，更多信息参见[协议文件](LICENSE)。