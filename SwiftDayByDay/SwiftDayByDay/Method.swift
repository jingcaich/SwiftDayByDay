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
        var somePoint = Point2(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        // ovenLight is now equal to .high
        ovenLight.next()
        // ovenLight is now equal to .off
        
        // MARK: 4.
        Method_SomeClass.someTypeMethod()
        var levelTracker = LevelTracker()
        // 因为 advance 前面加了 mutating 关键字所以, 必须是变量去调用, 不能以 LevelTracker().advance(to:) 进行调用, 默认常量
        levelTracker.advance(to: 20)
        
        var player = Player(name: "Argyrios")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // Prints "highest unlocked level is now 2
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // Prints "level 6 has not yet been unlocked
        
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

struct Point1 {
    var x = 0.0, y = 0.0
    // 加了 mutating 关键字, 即可修改内部的属性
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// 在 mutating 方法中对 self 进行赋值
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

// 4. 类型方法 (func 前面加上 class 或者 static 进行修饰)
// OC 中我们只能给类加上类型方法, 但在 Swift 中可以给枚举、结构体、类加上
// 静态方法可以调用另外一个静态方法、静态变量

class Method_SomeClass {
    class func someTypeMethod() {
        // 1. 类方法内部 self 隐式为类的类型
//        self == SomeClass.type
        // type method implementation goes here
    }
}

// 等级追踪
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    // 可以无视结果
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}



































































