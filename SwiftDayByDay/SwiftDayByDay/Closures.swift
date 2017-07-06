//
//  Closures.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/5.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Closures{
    
    
    // 1. 闭包分为三种
    //  1. 全局函数, 有名字并且没有捕获任何变量
    //  2. 嵌套行数, 有名字并且能在封闭的函数内捕获变量
    //  3. 匿名闭包...(常用的那种)
    
    func _sort() {
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        // 1. 可以传入方法, 根据方法来排序
        var reversedNames = names.sorted(by: backward)
        
        // 2. 闭包表达式, 参数可以是 in-out 参数, 但是他们不能有默认值, 能用可变参数, Tuple 也可以作为参数和返回值
//        { (parameters) -> return type in
//            statements
//        }
        // 3. 可以使用闭包来达到上述的效果
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            _ = s1 + s2
            return s1 > s2
        })
        reversedNames = names.sorted(by: { ( s1: String, s2: String) -> Bool in return s1 < s2 })
        
        // Swift 可以推断所需要的参数类型, 所以它的参数一定是 (String, String) -> Bool 类型, 所以没必要写出对应参数类型, 返回右箭头 -> 和 () 也不需要写了
        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        // 4. 单个表达式的闭包, 可以隐式 return, 所以可以再进一步简化 去除 omit
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        // 5. Shorthand argument name (速记参数名), 我们制定闭包的参数by $0,$1,$2 所以我们可以对上述 sorted 进一步进行简化
        reversedNames = names.sorted(by: {$0 > $1})
        
        // 6. Operator Methods, 实际上这里有更简短的方式去写上述闭包表达式
        reversedNames = names.sorted(by: >)
        
    }
    
    
    // Trailing Closures (尾闭包)
    // description: 如果你想要传递闭包给某个函数, 作为这个函数最后一个参数并且这个闭包表达式很长, 这个时候使用尾闭包是非常好的
    // 尾闭包写在函数 () 后面
    func _trailingClosures() {
        
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // function body goes here
        }
        // Here's how you call this function without using a trailing closure:
        // 就目前来说, 系统会自动推荐使用尾闭包
        someFunctionThatTakesAClosure(closure: {
            // closure's body goes here
        })
    
        // Here's how you call this function with a trailing closure instead:
        
        someFunctionThatTakesAClosure() {
            // trailing closure's body goes here
        }
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        // 所以这里我们也可以使用尾闭包来进行 sort 操作
        var reversedNames = names.sorted() {$0 > $1}
        // 1. 如果一个闭包表达式被提供了仅仅一个参数且是你传参数的时候给的是尾闭包, 这个时候你甚至可以去除 ()
        reversedNames = names.sorted {$0 > $1}
        // 2.
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        // 尾闭包 省去了多余的 map(_:)
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat {
                // 字典通过下标所取得的值都是可选的, 所以这里选择了强制解包
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        // strings is inferred to be of type [String]
        // its value is ["OneSix", "FiveEight", "FiveOneZero"]”
        
    }
    
    // Capturing Values 能捕获到上下文的变量和常量
    func _capturingValues() {
        
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            // amount 与 runningTotal 会 incrementer 被引用, 保证不会消失
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        
    }
}

























