//
//  Protocols&Extensions.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/30.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

// 类、枚举以及结构体都适用协议 (protocol)
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}

// 注意下这里的 mutating 关键字, 其改变了这个结构体的值, 而 SimpleClass 并不需要用 mutating 进行修饰, 因为 class 本身就能经常修改自己
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

// 尝试使用枚举去实现 exampleProtocol 但是并不支持定义属性 目前 protocol 是不支持 oc 中的 @optional
//enum ExampleEnum: ExampleProtocol {
//    var simpleDescription: String
//
//    case one
////    var simpleDescription: String
//    func adjust() {
//        print("123")
//    }
//}
// 可以尝试给 int 类增加某个协议的扩展
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

extension Double: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42.0
    }
    var absoluteValue:Double {
        return self>0 ? self: -self
    }
}


class ProtoclTest {
    func test() {
        
        let a = SimpleClass()
        a.adjust()
        _ = a.simpleDescription
        // 甚至可以作为一种类型
        let protocolValue: ExampleProtocol = a // runtime type 为 SimpleClass, 但是欺骗了编译器, 导致无法正常使用 a 的属性及函数出了 ExampleProtocol 中的属性和函数外
        print(protocolValue.simpleDescription)
        
        var b = SimpleStructure()
        b.adjust()
        _ = b.simpleDescription
        
        print(7.simpleDescription)

        
    }
}
