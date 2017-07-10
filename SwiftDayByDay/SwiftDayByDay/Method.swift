//
//  Method.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/10.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation


class _Method {
    
    // 简介: 主要和 OC 的差异为: Swift 中枚举和结构体支持方法
    
    func total() {
        
        let counter = Counter()
        // the initial counter value is 0
        counter.increment()
        // the counter's value is now 1
        counter.increment(by: 5)
        // the counter's value is now 6
        counter.reset()
        // the counter's value is now 0
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        
        
    }
    
    
}

// 1. 实例方法
// 实例方法和函数一样, 通过实例的点语法进行调用
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

// 2. self 属性同 oc, 不过类方法中并不同
// 3. 在实例方法中修改属性, 结构体和枚举是值类型, 默认情况下我们是不能修改通过实例方法修改其内部的属性
// 我们可以通过 mutating 关键字来进行修改

struct Point {
    var x = 0.0, y = 0.0
    // 加了 mutating 关键字, 即可修改内部的属性
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// 在 mutating 方法中对 self 进行赋值
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

